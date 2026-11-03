# dotfiles-yadm

Personal Linux dotfiles, managed with [yadm](https://yadm.io).
Files live in place in `$HOME`: no symlinks, no copies.

## Contents

- **Shell:** zsh, bash, profile
- **Editors:** Emacs (`.emacs.d`), Vim
- **Terminal:** Alacritty, tmux
- **Tools:** git, htop, fontconfig, rofi + rbw, pi agent config
- **Scripts:** `~/bin`, `~/.local/bin`

## Install

```sh
sudo pacman -S yadm
yadm clone git@github.com:Dr-Dd/dotfiles-yadm.git
```

After cloning:

- **tmux:** install [TPM](https://github.com/tmux-plugins/tpm), then press `prefix + I`.
- **Emacs:** packages install on first launch.

## Usage

yadm is git with `$HOME` as the work tree:

```sh
yadm status
yadm add ~/.config/foo/config
yadm commit -m "foo: ..."
yadm push
```

Untracked files are hidden (`status.showUntrackedFiles no`), so add files explicitly.
