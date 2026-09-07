# ============================================
# PATH Configuration
# ============================================
# This file is managed by dotfiles (stow)

# Add local scripts to PATH (tmux-sessionizer, etc.)
export PATH="$PATH:$HOME/.local/scripts"

# Go binaries
export PATH="$PATH:$HOME/.local/opt/go/bin"

# Tools installed by ~/.dotfiles/tools/install-tools
export PATH="$PATH:$HOME/.local/bin"

# Private Go modules (worktree-tui and friends) bypass the module proxy
export GOPRIVATE="github.com/arcadie99/*"

# Herd Lite (PHP)
export PATH="/Users/roscaarcadie/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/roscaarcadie/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# LM Studio
export PATH="$PATH:/Users/roscaarcadie/.lmstudio/bin"
