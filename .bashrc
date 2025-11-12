#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vim="nvim"
alias vi="nvim"
alias ff="fastfetch"
alias nf="neofetch"
alias files="nautilus"
eval "$(starship init bash)"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1

# Created by `pipx` on 2025-09-18 04:47:59
export PATH="$PATH:/home/alec/.local/bin"
