# .dotfiles

Personal dotfiles managed with GNU Stow, inspired by ThePrimeagen's setup.

## 📦 What's Included

- **zsh** - Zsh configuration (PATH, aliases, environment variables)
- **nvim** - Neovim configuration (Lua-based with lazy.nvim)
- **tmux** - Tmux configuration with Catppuccin theme
- **scripts** - Custom shell scripts (tmux-sessionizer, tmux-windowizer, tmux-cht.sh)

## 🚀 Installation

### Prerequisites

```bash
# Install GNU Stow
brew install stow
```

### Quick Install

```bash
# Clone the repo
git clone https://github.com/arcadie99/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run install script
./install
```

This will create symlinks from `~/.dotfiles/` to your home directory.

### Manual Installation

You can also install packages individually:

```bash
cd ~/.dotfiles

# Install specific packages
stow zsh       # Install Zsh config only
stow nvim      # Install Neovim config only
stow tmux      # Install Tmux config only
stow scripts   # Install scripts only

# Or install all at once
stow zsh nvim tmux scripts
```

## 🗑️ Uninstallation

```bash
# Uninstall everything
cd ~/.dotfiles
./uninstall

# Or uninstall specific packages
stow -D nvim
stow -D tmux
```

## 📁 Structure

```
~/.dotfiles/
├── zsh/
│   ├── .zshenv                      # Zsh environment → ~/.zshenv
│   └── .config/zsh/
│       ├── path.zsh                 # PATH configuration → ~/.config/zsh/path.zsh
│       └── aliases.zsh              # Aliases → ~/.config/zsh/aliases.zsh
├── nvim/.config/nvim/               # Neovim config → ~/.config/nvim/
├── tmux/.tmux.conf                  # Tmux config → ~/.tmux.conf
├── scripts/.local/scripts/          # Scripts → ~/.local/scripts/
├── install                          # Installation script
├── uninstall                        # Uninstallation script
└── README.md
```

## 🔄 How Stow Works

GNU Stow creates symbolic links from the dotfiles repo to your home directory.

Example:
- `~/.dotfiles/nvim/.config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `~/.dotfiles/tmux/.tmux.conf` → `~/.tmux.conf`

This means:
- ✅ All configs stay in one git repo
- ✅ Easy to backup and sync
- ✅ Changes are automatically reflected
- ✅ Safe to modify (edits go to the repo)

## 🛠️ Making Changes

1. Edit files in `~/.dotfiles/`
2. Changes are automatically reflected (via symlinks)
3. Commit and push to git

```bash
cd ~/.dotfiles
# Edit files...
git add .
git commit -m "Update configuration"
git push
```

## 📝 Adding New Configs

To add a new application config:

1. Create a directory named after the app
2. Mirror the home directory structure inside it
3. Add it to the install script

Example for zsh:
```bash
cd ~/.dotfiles
mkdir -p zsh
cp ~/.zshrc zsh/.zshrc
stow zsh
```

## 🎓 Inspired By

- [ThePrimeagen's dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- [GNU Stow guide](https://www.gnu.org/software/stow/)
