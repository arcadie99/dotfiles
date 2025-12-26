# ============================================
# ~/.zshenv
# ============================================
# This file is loaded FIRST by zsh, before .zshrc
# Managed by dotfiles (stow)

# Source all zsh configs from ~/.config/zsh/
if [ -d "$HOME/.config/zsh" ]; then
    for file in "$HOME/.config/zsh"/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
fi
