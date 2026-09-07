# .dotfiles

Personal dotfiles managed with GNU Stow, inspired by ThePrimeagen's setup.

## 📦 What's Included

- **zsh** - Zsh configuration (PATH, aliases, environment variables)
- **nvim** - Neovim configuration (Lua-based with lazy.nvim)
- **tmux** - Tmux configuration with Catppuccin theme
- **scripts** - Custom shell scripts (tmux-sessionizer, tmux-windowizer, tmux-cht.sh, tmux-worktrees, tmux-compose)
- **tools** - Manifest of external binaries (not a stow package - see [Tools](#-tools))

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


## 🔧 Tools

`install` handles configs (symlinks via stow). Binaries are handled separately by
`tools/install-tools`, which reads `tools/Toolfile` and installs each entry into
`~/.local/bin`.

```bash
./tools/install-tools
```

`Toolfile` format - one line per tool, `<kind>  <name>  <source>`:

```
go  worktree-tui  github.com/arcadie99/worktree-tui/cmd/worktree-tui@latest
```

`go` entries are installed with `go install`. To add a tool, add a line and re-run
the script.

Private repos need `GOPRIVATE` (set in `zsh/.config/zsh/path.zsh`) and a git
credential helper - `gh auth login` provides one.

### worktree-tui

A dashboard for git worktrees across projects, with the status of the AI agent
sessions in each. Bound to <kbd>prefix</kbd>+<kbd>g</kbd>, which opens it in a
centred tmux popup:

```tmux
bind-key g display-popup -E -w 90% -h 85% \
    -b rounded -S 'fg=#89b4fa' -T ' worktree-tui ' \
    "$HOME/.local/scripts/tmux-worktrees"
```

The popup is ephemeral (`-E`) - quitting the tool closes it. `tmux-worktrees` is a
launcher that resolves the binary, since a popup does not inherit the interactive
shell's PATH.

## ✍️ Composing input in nvim

CLI AI agents (Claude Code, cursor-agent, opencode) read their own input, so zsh's
`edit-command-line` cannot reach them. `tmux-compose` solves it one level up, in
tmux, so it works with any of them.

<kbd>prefix</kbd>+<kbd>e</kbd> opens nvim in a centred popup on a scratch `.md`
file. Write the message - several paragraphs, a numbered answer to a list of
questions, whatever - then `:wq`. The text is pasted into the pane you came from.

```tmux
bind-key e display-popup -E -w 90% -h 85% \
    -b rounded -S 'fg=#a6e3a1' -T ' compose ' \
    "$HOME/.local/scripts/tmux-compose '#{pane_id}'"
```

Two things make it work:

- **Bracketed paste** (`paste-buffer -p`). Without it every newline reads as Enter
  and the agent submits the message one line at a time.
- **No Enter is sent.** The text lands in the input and stays there, so you can
  review it and submit yourself.

The editor is `$VISUAL`, then `$EDITOR`, then `nvim`.

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
├── tools/                           # Binaries (NOT stowed)
│   ├── Toolfile                     # Manifest of tools to install
│   └── install-tools                # Installs them into ~/.local/bin
├── install                          # Installation script (configs)
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
