# ============================================
# Aliases
# ============================================
# This file is managed by dotfiles (stow)

# Git shortcuts
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -10'

# Tmux shortcuts
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias ts='tmux-sessionizer'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Dotfiles management
alias dotfiles='cd ~/.dotfiles'
alias dots='cd ~/.dotfiles'

# Neovim with icon variants
alias nv='nvim'                      # Neovim with Nerd Font icons (default)
alias nva='NVIM_USE_ASCII=1 nvim'    # Neovim with ASCII-only icons

# personal
# work

alias tpersonal='tmux -L personal attach || tmux -L personal'
alias twork='tmux -L work attach || tmux -L work'

