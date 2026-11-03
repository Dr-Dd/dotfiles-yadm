#!/usr/bin/env bash
#
# awg-thinkpad.sh - bring the AmneziaWG tunnel up/down and manage the
#                   matching DNS entries in resolv.conf.
#
# Usage: awg-thinkpad.sh {up|down|restart|dns|status}
#
# Settings can be overridden from the environment, e.g.:
#   AWG_IFACE=other awg-thinkpad.sh up

set -Eeuo pipefail

# --------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------
readonly IFACE="${AWG_IFACE:-thinkpad}"
readonly DNS_SEARCH="${AWG_DNS_SEARCH:-leonardoid.one}"
# Order matters: this is the order they appear in resolv.conf.
readonly -a DNS_SERVERS=("10.20.30.1")
readonly RESOLV_CONF="${RESOLV_CONF:-/etc/resolv.conf}"
readonly SCRIPT_NAME="${0##*/}"

TMP_RESOLV=""

# --------------------------------------------------------------------------
# Logging
# --------------------------------------------------------------------------
if [[ -t 2 ]]; then
    C_RED=$'\e[31m'; C_YEL=$'\e[33m'; C_GRN=$'\e[32m'; C_DIM=$'\e[2m'; C_OFF=$'\e[0m'
else
    C_RED=""; C_YEL=""; C_GRN=""; C_DIM=""; C_OFF=""
fi

_log() {  # _log LEVEL COLOR SYSLOG_PRIORITY MESSAGE...
    local level=$1 color=$2 prio=$3
    shift 3
    printf '%s%(%H:%M:%S)T%s %s%-5s%s %s\n' \
        "$C_DIM" -1 "$C_OFF" "$color" "$level" "$C_OFF" "$*" >&2
    if command -v logger >/dev/null 2>&1; then
        logger -t "$SCRIPT_NAME" -p "user.$prio" -- "$*" 2>/dev/null || true
    fi
}

info() { _log INFO  "$C_GRN" info    "$@"; }
warn() { _log WARN  "$C_YEL" warning "$@"; }
err()  { _log ERROR "$C_RED" err     "$@"; }
die()  { err "$@"; exit 1; }

cleanup() {
    if [[ -n $TMP_RESOLV ]]; then
        rm -f -- "$TMP_RESOLV"
    fi
}
trap cleanup EXIT
trap 'rc=$?; err "unexpected failure (exit $rc) at line $LINENO: $BASH_COMMAND"' ERR

# Log a command, then run it.
run() {
    info "running: $*"
    "$@"
}

usage() {
    cat <<EOF
Usage: $SCRIPT_NAME {up|down|restart|dns|status}

  up       bring the tunnel up (if needed) and apply DNS settings
  down     bring the tunnel down and remove DNS settings
  restart  down, then up
  dns      (re)apply DNS settings only; the tunnel must already be up
  status   show tunnel and DNS state (no root needed)
EOF
}

# --------------------------------------------------------------------------
# Helpers
# --------------------------------------------------------------------------
require_root() {
    (( EUID == 0 )) && return 0
    command -v sudo >/dev/null 2>&1 || die "root is required and sudo was not found"
    info "not root, re-running via sudo"
    exec sudo -- "$(readlink -f -- "${BASH_SOURCE[0]}")" "$@"
}

require_tools() {
    local tool
    for tool in awg-quick ip awk cmp mktemp readlink; do
        command -v "$tool" >/dev/null 2>&1 || die "required tool not found: $tool"
    done
}

iface_is_up() {
    ip link show dev "$IFACE" >/dev/null 2>&1
}

dns_is_applied() {
    local s
    [[ -r $RESOLV_CONF ]] || return 1
    for s in "${DNS_SERVERS[@]}"; do
        grep -qxF -- "nameserver $s" "$RESOLV_CONF" || return 1
    done
    grep -qxF -- "search $DNS_SEARCH" "$RESOLV_CONF"
}

# Rewrite resolv.conf.
#   add    - replace any 'search' lines with ours, put our block right after
#            the leading comment lines (idempotent)
#   remove - delete only the lines this script manages
# The file is rewritten in place (cat >), so a symlinked resolv.conf is
# not replaced by a regular file. Nothing is written if nothing changes.
rewrite_resolv() {
    local mode=$1 target

    [[ -e $RESOLV_CONF ]] || die "$RESOLV_CONF does not exist"
    target=$(readlink -f -- "$RESOLV_CONF")

    if [[ $target == /run/systemd/resolve/* || $target == /run/NetworkManager/* ]]; then
        warn "$RESOLV_CONF is managed by a resolver service ($target); changes may be overwritten"
    fi

    TMP_RESOLV=$(mktemp)

    awk -v mode="$mode" -v search="$DNS_SEARCH" -v servers="${DNS_SERVERS[*]}" '
        function norm(s) {
            gsub(/[[:space:]]+/, " ", s); sub(/^ /, "", s); sub(/ $/, "", s)
            return s
        }
        function emit_block(   i) {
            if (mode == "add" && !done) {
                print "search " search
                for (i = 1; i <= n; i++) print "nameserver " srv[i]
            }
            done = 1
        }
        BEGIN {
            n = split(servers, srv, " ")
            managed["search " search] = 1
            for (i = 1; i <= n; i++) managed["nameserver " srv[i]] = 1
        }
        !seen_body && /^[[:space:]]*#/ { print; next }   # keep leading comments
        {
            seen_body = 1
            emit_block()
            if (norm($0) in managed) next                # drop our old lines
            if (mode == "add" && $1 == "search") next    # only one search line
            print
        }
        END { emit_block() }                             # file had no body
    ' "$target" > "$TMP_RESOLV"

    if cmp -s -- "$target" "$TMP_RESOLV"; then
        info "resolv.conf already up to date (mode: $mode)"
        return 0
    fi

    cat -- "$TMP_RESOLV" > "$target"
    case $mode in
        add)    info "resolv.conf updated: search $DNS_SEARCH, nameservers ${DNS_SERVERS[*]}" ;;
        remove) info "resolv.conf cleaned: removed lines managed by this script" ;;
    esac
}

# --------------------------------------------------------------------------
# Commands
# --------------------------------------------------------------------------
cmd_up() {
    if iface_is_up; then
        warn "interface '$IFACE' is already up, skipping awg-quick"
    else
        run awg-quick up "$IFACE"
    fi
    rewrite_resolv add
}

# Returns non-zero if awg-quick failed; DNS is only cleaned when the
# tunnel is really gone, so a failed 'down' doesn't break a live tunnel.
cmd_down() {
    local rc=0
    if iface_is_up; then
        run awg-quick down "$IFACE" || rc=$?
    else
        warn "interface '$IFACE' is not up, only cleaning DNS"
    fi

    if iface_is_up; then
        err "interface '$IFACE' is still up (awg-quick exit $rc), leaving DNS untouched"
        return $(( rc != 0 ? rc : 1 ))
    fi
    rewrite_resolv remove
    return 0
}

cmd_restart() {
    cmd_down || warn "down failed, trying to continue with up"
    cmd_up
}

cmd_dns() {
    iface_is_up || die "interface '$IFACE' is not up; run 'up' first (or 'down' to clean DNS)"
    rewrite_resolv add
}

cmd_status() {
    local rc=0
    if iface_is_up; then info "tunnel '$IFACE': up"; else warn "tunnel '$IFACE': down"; rc=3; fi
    if dns_is_applied; then info "DNS: applied"; else warn "DNS: not applied"; fi
    return "$rc"
}

# --------------------------------------------------------------------------
# Main
# --------------------------------------------------------------------------
main() {
    local cmd=${1:-}

    case $cmd in
        up|down|restart|dns|status) ;;
        -h|--help|help) usage; exit 0 ;;
        *) [[ -n $cmd ]] && err "unknown command: $cmd"; usage >&2; exit 2 ;;
    esac

    [[ $cmd == status ]] || require_root "$@"
    require_tools

    case $cmd in
        up)      cmd_up ;;
        down)    cmd_down ;;
        restart) cmd_restart ;;
        dns)     cmd_dns ;;
        status)  cmd_status ;;
    esac
}

# Allow sourcing for tests without running anything.
if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
    main "$@"
fi
