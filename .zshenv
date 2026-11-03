export EDITOR=vim
export VISUAL=vim

# (N) drops directories that don't exist; -U removes duplicates
typeset -U path
path=(~/bin(N) ~/.local/bin(N) $path ~/.local/share/JetBrains/Toolbox/scripts(N))
