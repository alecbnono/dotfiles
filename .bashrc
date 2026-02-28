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
alias ipynb-export='jupyter nbconvert --to pdf --execute --ExecutePreprocessor.kernel_name="python3"'
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1

export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Created by `pipx` on 2025-09-18 04:47:59
export PATH="$PATH:/home/alec/.local/bin"

nvim-nuke() {
    echo "Nuking Neovim share, state, and cache..."
    
    # 1. Remove the plugin installations (where lazy.nvim/mason live)
    rm -rf ~/.local/share/nvim
    
    # 2. Remove state (undo history, search history, shada)
    rm -rf ~/.local/state/nvim
    
    # 3. Remove the cache (temporary files)
    rm -rf ~/.cache/nvim
    
    echo "Done. Restart nvim to re-trigger plugin installation."
}

eval "$(starship init bash)"
