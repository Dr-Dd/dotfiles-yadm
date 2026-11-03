#!/usr/bin/env bash
# Usage: sysupdate.sh [WRK01_MAC]   (MAC only needed if wrk01 is asleep)
set -u
SRV_IP=10.22.145.33          # srv01 (DNS/DHCP); IP used to bypass stuck DNS
WRK_MAC="${1:-B4:2E:99:69:A5:1D}"
WRK_IP=10.22.145.100             # wrk01 MAC for wake-on-lan
BCAST=10.22.145.255
DOM=leonardoid.one

local_update() {
  sudo pacman -Syu --noconfirm
  yay -Sua --noconfirm
  flatpak update --user -y; sudo flatpak update --system -y; sudo flatpak uninstall --system --unused -y; flatpak uninstall --user --unused -y
  command -v pipx >/dev/null && pipx upgrade-all
  sudo npm update -g
  fwupdmgr refresh --force; fwupdmgr get-updates && fwupdmgr update
  pacman -Qtdq 2>/dev/null | sudo pacman -Rns --noconfirm - 2>/dev/null
  pacman -Qe >/dev/null; find /etc -name '*.pacnew' 2>/dev/null
}

# Remote update script: detects the package manager
REMOTE='
if command -v pacman >/dev/null; then sudo pacman -Syu --noconfirm
elif command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get -y full-upgrade && sudo apt-get -y autoremove
elif command -v dnf >/dev/null; then sudo dnf -y upgrade
fi
command -v flatpak >/dev/null && { sudo flatpak update --system -y --noninteractive; sudo flatpak uninstall --system --unused -y; }
command -v fwupdmgr >/dev/null && { fwupdmgr refresh --force; fwupdmgr update -y; }
[ -f /var/run/reboot-required ] && echo ">> reboot required"
true
'

# Fix stuck DNS: put srv01 back first on wlan0 (non-persistent), flush caches
fix_dns() {
  local l; l=$(ip -o route get "$SRV_IP" | sed -n 's/.* dev \([^ ]*\).*/\1/p')
  sudo resolvectl dns "$l" "$SRV_IP" 1.1.1.1
  sudo resolvectl flush-caches
}

remote() { # $1=host/ip
  ssh -t -o ConnectTimeout=8 "$1" "$REMOTE"
}

echo "== local =="; local_update
echo "== srv01 =="; fix_dns
remote "$SRV_IP"

echo "== wrk01 =="
if ! ping -c1 -W2 "$WRK_IP" >/dev/null 2>&1; then
  [ -n "$WRK_MAC" ] || { echo "wrk01 down; rerun with its MAC"; exit 1; }
  wakeonlan -i "$BCAST" "$WRK_MAC"
  for i in $(seq 40); do ping -c1 -W2 "$WRK_IP" >/dev/null 2>&1 && break; sleep 5; done
  sleep 15
fi
remote "$WRK_IP"
