# Dotfiles Mini Wiki

Quick reference pentru configuratia mea de development.
Setup bazat pe **GNU Stow** | Theme: **Catppuccin** peste tot.

---

## Instalare / Dezinstalare

```bash
cd ~/.dotfiles
./install          # stow all (zsh, nvim, tmux, scripts)
./uninstall        # remove all symlinks

stow nvim          # install doar un pachet
stow -D nvim       # remove doar un pachet
```

---

## Zsh Aliases

### Git

| Alias | Comanda                              |
|-------|--------------------------------------|
| `gs`  | `git status -sb`                     |
| `ga`  | `git add`                            |
| `gaa` | `git add --all`                      |
| `gc`  | `git commit`                         |
| `gcm` | `git commit -m`                      |
| `gp`  | `git push`                           |
| `gl`  | `git log --oneline --graph` (10)     |

### Tmux

| Alias | Ce face                        |
|-------|--------------------------------|
| `ta`  | Attach la o sesiune tmux       |
| `tl`  | Lista sesiuni tmux             |
| `ts`  | Lanseaza tmux-sessionizer      |

### Navigare

| Alias      | Ce face                |
|------------|------------------------|
| `..`       | `cd ..`                |
| `...`      | `cd ../..`             |
| `....`     | `cd ../../..`          |
| `dotfiles` | `cd ~/.dotfiles`       |
| `dots`     | `cd ~/.dotfiles`       |

### Neovim

| Alias | Ce face                          |
|-------|----------------------------------|
| `nv`  | Neovim (Nerd Font icons)         |
| `nva` | Neovim (ASCII icons, no fonts)   |

---

## Neovim

**Leader key: `Space`**

### Keybindings

#### LSP

| Keys           | Actiune                    |
|----------------|----------------------------|
| `K`            | Hover documentation        |
| `gd`           | Go to definition           |
| `<leader>ca`   | Code actions               |
| `<leader>gf`   | Format buffer              |

#### Telescope (Fuzzy Finder)

| Keys           | Actiune                    |
|----------------|----------------------------|
| `Ctrl+f`       | Find files                 |
| `<leader>ff`   | Find files                 |
| `<leader>fg`   | Live grep (cauta in continut) |
| `<leader>fb`   | Buffere deschise           |
| `<leader>fh`   | Help tags                  |
| `<leader>fv`   | Git files                  |
| `<leader>vf`   | Git status (fisiere modificate) |

#### Neo-tree (File Explorer)

| Keys           | Actiune                    |
|----------------|----------------------------|
| `<leader>nn`   | Toggle file explorer       |

#### Git

| Keys           | Actiune                    |
|----------------|----------------------------|
| `<leader>gp`   | Preview git hunk           |
| `<leader>gt`   | Toggle line blame          |

#### Completion

| Keys           | Actiune                    |
|----------------|----------------------------|
| `Ctrl+Space`   | Trigger completion         |
| `Tab`          | Next item / snippet jump   |
| `Enter`        | Confirm selection          |
| `Ctrl+e`       | Abort completion           |
| `Ctrl+b`       | Scroll docs up             |
| `Ctrl+f`       | Scroll docs down           |

### Plugins instalate

| Plugin            | Rol                                    |
|-------------------|----------------------------------------|
| catppuccin        | Color scheme                           |
| lualine           | Status bar                             |
| neo-tree          | File explorer                          |
| telescope         | Fuzzy finder                           |
| mason             | LSP server installer                   |
| nvim-lspconfig    | LSP configuration                      |
| nvim-cmp          | Autocompletion                         |
| LuaSnip           | Snippets                               |
| treesitter        | Syntax highlighting                    |
| none-ls           | Formatters (prettier, stylua)          |
| gitsigns          | Git diff markers                       |
| vim-fugitive      | Git wrapper                            |
| autopairs         | Auto-close brackets                    |
| nvim-ts-autotag   | Auto-close HTML tags                   |

### LSP Servers configurate

| Server        | Limbaj                     |
|---------------|----------------------------|
| lua_ls        | Lua                        |
| ts_ls         | TypeScript / JavaScript    |
| clangd        | C / C++                    |
| intelephense  | PHP                        |
| phpactor      | PHP                        |
| volar         | Vue.js                     |

### Treesitter parsers

lua, vue, javascript, typescript, c, html, css, python, json, php

---

## Tmux

### Setari de baza

- **Prefix:** `Ctrl+b` (default)
- **Mouse:** activat
- **Key mode:** Vi bindings
- **Status bar:** sus
- **Index:** porneste de la 1

### Keybindings (dupa prefix)

#### Navigare panes (Vi-style)

| Key | Actiune       |
|-----|---------------|
| `h` | Pane stanga   |
| `j` | Pane jos      |
| `k` | Pane sus      |
| `l` | Pane dreapta  |

#### Scripturi

| Key | Actiune                              |
|-----|--------------------------------------|
| `f` | tmux-sessionizer (switch proiecte)   |
| `i` | tmux-cht.sh (cheatsheets)            |
| `y` | Display popup                        |

---

## Scripturi Custom

### tmux-sessionizer (`ts` sau `prefix + f`)

Navigare rapida intre proiecte cu fzf.

```
Cauta in:
  ~/Developer/github
  ~/Developer/mit-dev/code
  ~/
  ~/Developer
```

- Selectezi un director → creeaza/switch la sesiunea tmux cu acel nume
- Poti da si direct: `ts /path/to/project`

### tmux-cht.sh (`prefix + i`)

Cheatsheets rapide via cht.sh.

1. Selectezi limbaj sau comanda din lista
2. Scrii query-ul
3. Se deschide rezultatul intr-un window nou

**Limbaje disponibile:** golang, nodejs, javascript, typescript, python, rust, c, cpp, lua, php, bash, zsh, css, html, etc.

**Comenzi disponibile:** git, docker, find, grep, sed, awk, tar, ssh, make, jq, cargo, stow, etc.

### tmux-windowizer

Creeaza tmux windows pentru git branches.

```bash
tmux-windowizer "feature/login" npm test
# → creeaza window "feature__login" si ruleaza "npm test"
```

---

## Structura fisierelor

```
~/.dotfiles/
├── zsh/                        # Shell config
│   ├── .zshenv                 # Loads all .zsh files
│   └── .config/zsh/
│       ├── path.zsh            # PATH dirs
│       └── aliases.zsh         # Aliases
├── nvim/                       # Editor config
│   └── .config/nvim/
│       ├── init.lua            # Entry point (lazy.nvim bootstrap)
│       └── lua/
│           ├── vim-basic-config.lua
│           ├── icons.lua       # ASCII / Nerd Font icons
│           └── plugins/        # Un fisier per plugin
├── tmux/                       # Terminal multiplexer
│   ├── .tmux.conf
│   ├── .tmux-cht-languages     # Limbaje pt cheatsheet
│   └── .tmux-cht-command       # Comenzi pt cheatsheet
├── scripts/                    # Utility scripts
│   └── .local/scripts/
│       ├── tmux-sessionizer
│       ├── tmux-windowizer
│       └── tmux-cht.sh
├── install                     # ./install → stow all
└── uninstall                   # ./uninstall → remove all
```

---

## Tips rapide

- **Deschide Neovim fara Nerd Fonts:** `nva` (foloseste ASCII icons)
- **Cauta un fisier rapid:** `Ctrl+f` in Neovim
- **Cauta text in proiect:** `<Space>fg` in Neovim
- **Switch rapid intre proiecte:** `ts` in terminal sau `prefix+f` in tmux
- **Cheatsheet rapid:** `prefix+i` in tmux → selectezi topic → scrii intrebarea
- **Format code:** `<Space>gf` in Neovim
- **Git blame pe linie:** `<Space>gt` in Neovim
- **File explorer:** `<Space>nn` in Neovim
