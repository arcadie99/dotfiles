#!/usr/bin/env bash

# For using in the home directory
# DOTFILES_DIR="$HOME/dotfiles"

# For testing configuration in the docker container
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Backup existing file
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing $target${NC}"
        mv "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Remove existing symlink
    [ -L "$target" ] && rm "$target"
    
    # Create new symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}Created symlink: $target -> $source${NC}"
}

# ########################################
# Configuration
# ########################################

# Tmux configuration
mkdir -p "$HOME/.config/tmux"
create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

# Neovim configuration
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"


echo -e "${GREEN}Dotfiles installation complete!${NC}"
