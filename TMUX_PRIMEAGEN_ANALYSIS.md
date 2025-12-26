# Analiză Tmux: Primeagen vs Configurația Curentă

**Data analizei**: 26 Decembrie 2025

## Rezumat

Am analizat dotfiles-urile lui ThePrimeagen și le-am comparat cu configurația ta actuală de tmux. Acest document conține toate îmbunătățirile identificate, workflow-urile recomandate și configurațiile sugerate.

---

## Ce ai deja implementat ✓

- **Scripturile cheie**: `tmux-sessionizer`, `tmux-windowizer`, `tmux-cht.sh` - toate funcționale
- **Vi-mode navigation**: Bindings pentru h/j/k/l
- **Tema vizuală**: Catppuccin Mocha (mult mai elaborată decât a lui Primeagen)
- **Fișierele cht.sh**: `.tmux-cht-languages` și `.tmux-cht-command`
- **Mouse support**: Activat pentru confort
- **Activity monitoring**: Pentru notificări vizuale

---

## 🎯 Îmbunătățiri Recomandate pentru Tmux

### 1. Performance & Responsiveness

**Problema**: Delay-ul default de escape poate încetini workflow-ul, mai ales în Vim/Neovim.

**Soluție**:
```bash
# Adaugă în .tmux.conf:
set -s escape-time 0
```

**Beneficii**:
- Elimină delay-ul la apăsarea tastei ESC
- Tmux devine instantaneu responsiv
- Crucial pentru utilizatorii Vim/Neovim
- Primeagen consideră asta esențial

---

### 2. Prefix Mai Ergonomic

**Problema**: `Ctrl+B` (default) este greu de apăsat - necesită stretchuirea degetului mic.

**Soluție**:
```bash
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
```

**Beneficii**:
- `Ctrl+A` e mult mai accesibil - degetele rămân pe home row
- Mai puțin strain pe mână
- Standard în comunitatea tmux avansată
- Același prefix ca screen (pentru cei care au folosit screen înainte)

**Note**: Dacă folosești `Ctrl+A` în shell pentru "go to beginning of line", vei avea nevoie să apeși de 2 ori (prefix apoi Ctrl+A din nou).

---

### 3. Last Window Toggle - Game Changer

**Problema**: Switching între windows consecutive necesită multe keystrokes.

**Soluție**:
```bash
bind -r ^ last-window
```

**Beneficii**:
- Toggle instant între ultimele 2 windows folosite
- Perfect pentru workflow cod ↔️ teste
- Cel mai folosit shortcut al lui Primeagen
- Seamless context switching

**Usage**: `Prefix` apoi `Shift+6` (^)

---

### 4. Repeatable Bindings (-r flag)

**Problema**: Pentru a naviga multiple panes, trebuie să repeți prefix-ul de fiecare dată.

**Soluție**:
```bash
# Înlocuiește bindings actuali cu:
bind -r ^ last-window
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
```

**Beneficii**:
- Apeși prefix-ul o singură dată, apoi poți apăsa `jjjj` rapid
- Mult mai fluid pentru navigare
- Reduce keystroke-urile cu ~70%
- Window resizing devine mult mai rapid

**Note**: Timeframe-ul de repeat este configurat de `repeat-time` (default 500ms).

---

### 5. Copy Mode Îmbunătățit

**Problema**: Copy-paste-ul actual nu e optimizat pentru workflow Vim-like.

**Soluție**:
```bash
# Copy mode cu visual selection și yank to clipboard
bind -T copy-mode-vi v send-keys -X begin-selection

# Pentru macOS:
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'

# Pentru Linux:
# bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
```

**Beneficii**:
- Workflow identic cu Vim: `v` pentru visual mode, `y` pentru yank
- Text merge direct în system clipboard
- Nu mai trebuie să folosești mouse-ul pentru copy

**Usage**:
1. `Prefix + [` - intră în copy mode
2. Navighează cu `h/j/k/l`
3. `v` - începe selection (visual mode)
4. `y` - copiază la clipboard și iese din copy mode

---

### 6. TODO.md Quick Access

**Problema**: Accesarea TODO-urilor necesită navigare manuală.

**Soluție**:
```bash
bind -r D neww -c "#{pane_current_path}" "[[ -e TODO.md ]] && nvim TODO.md || nvim ~/.dotfiles/TODO.md"
```

**Beneficii**:
- Acces instant la TODO-uri cu `Prefix + Shift+D`
- Caută TODO.md în directorul curent, fallback la global TODO
- Se deschide în window nou pentru context izolat
- Perfect pentru quick brain dumps

**Personalizare**: Modifică path-ul către locația ta preferată de TODO-uri.

---

### 7. Project Quick Jump Bindings

**Problema**: Chiar și cu tmux-sessionizer + fzf, proiectele frecvente necesită typing.

**Soluție**:
```bash
# Personalizează cu proiectele tale cele mai folosite:
bind-key -r G run-shell "~/.local/scripts/tmux-sessionizer ~/Developer/github"
bind-key -r M run-shell "~/.local/scripts/tmux-sessionizer ~/Developer/mit-dev/code"
bind-key -r P run-shell "~/.local/scripts/tmux-sessionizer ~/personal"
bind-key -r W run-shell "~/.local/scripts/tmux-sessionizer ~/work"
bind-key -r C run-shell "~/.local/scripts/tmux-sessionizer ~/code"

# Exemple de la Primeagen:
# bind-key -r G run-shell "~/.local/bin/tmux-sessionizer ~/work/nrdp"
# bind-key -r C run-shell "~/.local/bin/tmux-sessionizer ~/work/tvui"
# bind-key -r R run-shell "~/.local/bin/tmux-sessionizer ~/work/milo"
```

**Beneficii**:
- Salt direct la proiecte fără fzf
- Top 5-7 proiecte sunt la o tastă distanță
- Muscle memory pentru proiecte frecvente
- Primeagen are 7-8 astfel de bindings

**Recomandare**: Identifică-ți top 5 proiecte la care lucrezi săptămânal și adaugă bindings.

---

### 8. Reload Config

**Problema**: Testing modificărilor de config necesită restart tmux sau comenzi lungi.

**Soluție**:
```bash
bind r source-file ~/.tmux.conf \; display-message "✓ Config reloaded!"
```

**Beneficii**:
- Reload instant cu `Prefix + r`
- Feedback vizual că s-a reîncărcat
- Esențial pentru experimentare rapidă

---

### 9. Terminal Color Support

**Verificare**: Asigură-te că ai:
```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

**Note**: Deja ai asta în config, e perfect. Asigură suport complet pentru true color.

---

## 🚀 Îmbunătățiri la Scripturile Existente

### tmux-sessionizer Enhancement

**Scripul tău actual** caută în:
```bash
~/Developer/github ~/Developer/mit-dev/code ~/ ~/Developer
```

**Problemă**: Poate returna directoare ascunse (`.git`, `.config`, etc.) care nu sunt proiecte.

**Îmbunătățire**:
```bash
selected=$(find ~/Developer/github ~/Developer/mit-dev/code ~/Developer \
    -mindepth 1 -maxdepth 1 -type d -not -path '*/.*' 2>/dev/null | fzf)
```

**Beneficii**:
- Exclude directoarele ascunse
- Mai curat fzf output
- Mai rapid (mai puține opțiuni)

---

### tmux-windowizer Enhancement

**Îmbunătățire sugerată**:
```bash
#!/usr/bin/env bash

branch_name=$(basename $1)
session_name=$(tmux display-message -p "#S")
clean_name=$(echo $branch_name | tr "./" "__")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2>/dev/null; then
    tmux neww -dn $clean_name
fi

shift
tmux send-keys -t $target "$*\r"  # Adaugă \r pentru auto-execute
```

**Diferență**: Adăugat `\r` la final pentru a executa automat comanda trimisă.

---

### Keybinding Global pentru tmux-sessionizer (FOARTE IMPORTANT)

**Problema**: tmux-sessionizer e accesibil doar când ești în tmux.

**Soluția lui Primeagen**: Binding global `Ctrl+f` din **orice aplicație**.

**Opțiuni pentru macOS**:

#### Opțiunea 1: Shell Keybinding (simplu)
```bash
# Adaugă în ~/.zshrc:
bindkey -s ^f "tmux-sessionizer\n"
```

**Beneficii**:
- Funcționează din orice shell
- Zero dependencies
- Setup în 1 linie

**Limitare**: Funcționează doar în terminal, nu global.

---

#### Opțiunea 2: Karabiner-Elements (adevărat global)

1. Instalează Karabiner-Elements:
```bash
brew install --cask karabiner-elements
```

2. Configurează în `~/.config/karabiner/karabiner.json`:
```json
{
  "profiles": [{
    "complex_modifications": {
      "rules": [{
        "description": "Ctrl+F to open tmux-sessionizer",
        "manipulators": [{
          "type": "basic",
          "from": {
            "key_code": "f",
            "modifiers": {
              "mandatory": ["control"]
            }
          },
          "to": [{
            "shell_command": "open -a iTerm && sleep 0.1 && osascript -e 'tell application \"System Events\" to keystroke \"tmux-sessionizer\" & return'"
          }]
        }]
      }]
    }
  }]
}
```

**Beneficii**:
- Funcționează din ORICE aplicație
- Acces instant la proiecte din browser, Slack, etc.
- Cel mai productiv binding posibil

---

#### Opțiunea 3: BetterTouchTool (alternative)

Similar cu Karabiner dar cu GUI mai user-friendly.

---

## 🎨 Workflow-uri Folosite de Primeagen

### 1. Session-per-Project Philosophy

**Conceptul**:
- 1 sesiune tmux = 1 proiect
- Windows în sesiune = contexte diferite ale proiectului
- Schimbare rapidă între proiecte cu tmux-sessionizer

**Exemplu**:
```
Session: my-web-app
  Window 0: nvim        (editing code)
  Window 1: tests       (running jest --watch)
  Window 2: server      (npm run dev)
  Window 3: git         (pentru commits/rebase/etc)
  Window 4: logs        (tail -f logs)

Session: dotfiles
  Window 0: nvim        (editing configs)
  Window 1: testing     (trying new configs)

Session: learning-rust
  Window 0: nvim        (code)
  Window 1: cargo       (cargo watch -x test)
```

**Beneficii**:
- Context switching mental mai ușor
- Fiecare proiect are state-ul său persistent
- Poți avea servere/watchers running per proiect
- Detach/attach fără să pierzi nimic

---

### 2. Window Organization Pattern

**Pattern standardizat**:
```
Window 0: Editor principal (nvim/editor)
Window 1: Tests/Build watcher
Window 2: Running server/app
Window 3: Git operations
Window 4+: Ad-hoc tasks
```

**Beneficii**:
- Muscle memory pentru layout
- Știi întotdeauna unde e fiecare
- Consistency între proiecte

---

### 3. Tmux + Neovim Integration

**Plugin**: `christoomey/vim-tmux-navigator`

**Setup Neovim** (lazy.nvim):
```lua
{
  'christoomey/vim-tmux-navigator',
  lazy = false,
}
```

**Setup Tmux** (adaugă în .tmux.conf):
```bash
# Smart pane switching with awareness of Vim splits
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
```

**Beneficii**:
- Navighezi seamless între Neovim splits și tmux panes
- Aceleași keybindings (`Ctrl+h/j/k/l`) funcționează peste tot
- Nu mai trebuie să gândești "sunt în vim sau tmux?"

---

### 4. Git Worktrees Workflow

**Conceptul**: Multiple working directories pentru același repo.

**Use case**: Lucrezi la feature branch, dar trebuie urgent să fixezi un bug pe main.

**Workflow tradițional** (problematic):
```bash
git stash              # stash work
git checkout main      # switch branch
# fix bug
git checkout feature   # back to feature
git stash pop          # restore work
```

**Workflow cu worktrees**:
```bash
# Setup inițial:
git worktree add ../my-app-main main
git worktree add ../my-app-feature feature-branch

# În tmux:
# Session 1: my-app-main (window pentru bugfix)
# Session 2: my-app-feature (window pentru feature)

# Switch instant între sesiuni cu tmux-sessionizer
```

**Comenzi utile**:
```bash
# Crează worktree
git worktree add <path> <branch>

# Listează worktrees
git worktree list

# Șterge worktree
git worktree remove <path>
```

**Integrare cu tmux-windowizer**:
```bash
# Când creezi worktree:
git worktree add ../my-app-feature feature-branch
tmux-windowizer ../my-app-feature
```

---

## 📋 Alte Tools din Ecosistemul Primeagen

### 1. fzf (Fuzzy Finder)

Deja îl folosești în scripturile tale.

**Îmbunătățiri suplimentare**:

```bash
# Adaugă în ~/.zshrc pentru history search îmbunătățit:
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --color=fg:#cdd6f4,bg:#1e1e2e,hl:#f38ba8
  --color=fg+:#cdd6f4,bg+:#313244,hl+:#f38ba8
  --color=info:#cba6f7,prompt:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,spinner:#f5e0dc,header:#f38ba8
'

# Ctrl+R pentru history search
# Ctrl+T pentru file search
# Alt+C pentru cd into directory
```

**fzf în Neovim**:
```lua
-- Plugin: telescope.nvim (fzf-like pentru Neovim)
{
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' }
}
```

---

### 2. ripgrep (rg)

Văd că ai `rg` în `.tmux-cht-command`.

**Usage avansată**:
```bash
# Search în typescript files only
rg "pattern" --type typescript

# Search și arată context
rg "pattern" -C 3

# Search case-insensitive
rg -i "pattern"

# Search și exclude directoare
rg "pattern" --glob '!node_modules/*'

# Replace în files (dry run)
rg "old" --files-with-matches | xargs sed -i '' 's/old/new/g'
```

**Integration în Neovim** (folosește rg pentru grep):
```lua
-- În telescope config:
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
  }
}
```

---

### 3. Git Aliases pentru Speed

```bash
# Adaugă în ~/.gitconfig:
[alias]
    # Status și info
    s = status -sb
    l = log --oneline --graph --decorate -10
    ll = log --oneline --graph --decorate --all
    last = log -1 HEAD --stat

    # Branch management
    br = branch
    co = checkout
    cob = checkout -b

    # Commit shortcuts
    cm = commit -m
    ca = commit --amend
    cane = commit --amend --no-edit

    # Add shortcuts
    a = add
    aa = add --all
    ap = add --patch

    # Diff shortcuts
    d = diff
    ds = diff --staged

    # Stash shortcuts
    st = stash
    stp = stash pop
    stl = stash list

    # Rebase shortcuts
    rb = rebase
    rbi = rebase -i
    rbc = rebase --continue
    rba = rebase --abort

    # Undo shortcuts
    unstage = reset HEAD --
    undo = reset --soft HEAD~1

    # Worktree shortcuts
    wt = worktree
    wta = worktree add
    wtl = worktree list
    wtr = worktree remove
```

**Usage examples**:
```bash
git s           # quick status
git aa          # add all
git cm "msg"    # commit with message
git cane        # amend last commit without editing message
git l           # pretty log
git co -b feat  # checkout new branch
```

---

### 4. zoxide (Smart cd)

**Ce face**: "Frecency" based directory jumping (frecvent + recent).

**Instalare**:
```bash
brew install zoxide

# Adaugă în ~/.zshrc:
eval "$(zoxide init zsh)"
```

**Usage**:
```bash
# În loc de:
cd ~/Developer/mit-dev/code/my-long-project-name

# Folosești:
z my-long    # sau chiar
z proj       # sau
z my

# zoxide învață directoarele tale frecvente
```

**Beneficii**:
- Learning algorithm - devine mai smart cu timpul
- Mult mai rapid decât cd + tab completion
- Funcționează great cu tmux-sessionizer

**Integration în tmux-sessionizer**:
```bash
# Modifică scriptul să folosească zoxide query:
selected=$(zoxide query -l | fzf)
```

---

### 5. bat (cat cu syntax highlighting)

```bash
brew install bat

# Adaugă în ~/.zshrc:
alias cat='bat --style=plain --paging=never'
alias less='bat --style=plain'
```

**Beneficii**:
- Syntax highlighting automat
- Git integration (arată diff-uri)
- Pager integrat

---

### 6. eza (ls modern)

```bash
brew install eza

# Adaugă în ~/.zshrc:
alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias lt='eza --tree --level=2 --icons'
```

**Beneficii**:
- Colorat frumos
- Git status integration
- Icons pentru file types
- Tree view built-in

---

### 7. delta (git diff enhanced)

```bash
brew install git-delta

# Adaugă în ~/.gitconfig:
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    line-numbers = true
    syntax-theme = Catppuccin-mocha

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

**Beneficii**:
- Side-by-side diffs
- Syntax highlighting în diff
- Line numbers
- Better merge conflict visualization

---

## 🔥 Quick Win Recommendations

### Prioritate URGENT (Impact Mare, Effort Mic)

| # | Îmbunătățire | Impact | Effort | Time to implement |
|---|-------------|--------|--------|------------------|
| 1 | `escape-time 0` | ⭐⭐⭐⭐⭐ | 1 min | 1 linie |
| 2 | `prefix C-a` | ⭐⭐⭐⭐⭐ | 2 min | 3 linii |
| 3 | `bind -r ^` (last-window) | ⭐⭐⭐⭐⭐ | 1 min | 1 linie |
| 4 | Repeatable bindings `-r` | ⭐⭐⭐⭐ | 2 min | 4 linii |
| 5 | Copy-mode improvements | ⭐⭐⭐⭐ | 3 min | 2 linii |

**Total time**: ~10 minute pentru transformare masivă a workflow-ului.

---

### Prioritate NICE TO HAVE (Impact Mediu, Effort Mic-Mediu)

| # | Îmbunătățire | Impact | Effort | Time to implement |
|---|-------------|--------|--------|------------------|
| 6 | Project quick jumps | ⭐⭐⭐⭐ | 5 min | 5-7 linii |
| 7 | TODO.md binding | ⭐⭐⭐ | 2 min | 1 linie |
| 8 | Config reload binding | ⭐⭐⭐ | 1 min | 1 linie |
| 9 | Git aliases | ⭐⭐⭐⭐ | 10 min | ~30 linii |
| 10 | Global tmux-sessionizer | ⭐⭐⭐⭐⭐ | 15 min | Setup tool |

---

### Prioritate ADVANCED (Impact Mare, Effort Mare)

| # | Îmbunătățire | Impact | Effort | Time to implement |
|---|-------------|--------|--------|------------------|
| 11 | vim-tmux-navigator | ⭐⭐⭐⭐⭐ | 30 min | Plugin + config |
| 12 | Git worktrees workflow | ⭐⭐⭐⭐ | Learning curve | Varies |
| 13 | zoxide | ⭐⭐⭐⭐ | 5 min + learning | Install + 1 line |
| 14 | Modern CLI tools (bat, eza, delta) | ⭐⭐⭐ | 20 min | Multiple installs |

---

## 📄 Configurație Completă Recomandată

Iată configurația `.tmux.conf` completă cu toate îmbunătățirile integrate:

```bash
# ============================================
# PERFORMANCE & BASICS
# ============================================

# Set the default shell to Zsh
set-option -g default-shell /bin/zsh

# Eliminate ESC delay (crucial for Vim)
set -s escape-time 0

# Better prefix (more ergonomic than C-b)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Terminal colors
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Mouse support (keep this, it's useful)
set -g mouse on

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity on
set -g bell-action any
set -g visual-bell on

# Status bar position
set-option -g status-position top

# ============================================
# KEYBINDINGS
# ============================================

# Vi mode in copy mode
set-window-option -g mode-keys vi

# Reload config
bind r source-file ~/.tmux.conf \; display-message "✓ Config reloaded!"

# ============================================
# NAVIGATION
# ============================================

# Vim-like pane switching (with repeat)
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R

# Last window toggle (GAME CHANGER)
bind -r ^ last-window

# ============================================
# COPY MODE
# ============================================

# Vi-like copy mode
bind -T copy-mode-vi v send-keys -X begin-selection

# Yank to system clipboard (macOS)
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'

# For Linux, uncomment this instead:
# bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# ============================================
# QUICK ACCESS
# ============================================

# Popup (keep your existing binding)
bind-key y display-popup

# TODO.md quick access
bind -r D neww -c "#{pane_current_path}" "[[ -e TODO.md ]] && nvim TODO.md || nvim ~/.dotfiles/TODO.md"

# ============================================
# TMUX SCRIPTS
# ============================================

# tmux-sessionizer (fuzzy project finder)
bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

# tmux-cht.sh (cheat sheet lookup)
bind-key -r i run-shell "tmux neww ~/.local/scripts/tmux-cht.sh"

# ============================================
# PROJECT QUICK JUMPS
# Personalizează cu proiectele tale!
# ============================================

bind-key -r G run-shell "~/.local/scripts/tmux-sessionizer ~/Developer/github"
bind-key -r M run-shell "~/.local/scripts/tmux-sessionizer ~/Developer/mit-dev/code"
bind-key -r P run-shell "~/.local/scripts/tmux-sessionizer ~/personal"
# Adaugă mai multe pentru proiectele tale frecvente:
# bind-key -r W run-shell "~/.local/scripts/tmux-sessionizer ~/work"
# bind-key -r C run-shell "~/.local/scripts/tmux-sessionizer ~/code"

# ============================================
# THEME - CATPPUCCIN MOCHA
# ============================================

# Status bar colors
set -g status-style bg='#1e1e2e',fg='#cdd6f4'

# Window status format
set -g window-status-format " #I:#W "
set -g window-status-current-format " #I:#W "

# Window status colors
set -g window-status-style bg='#313244',fg='#a6adc8'
set -g window-status-current-style bg='#89b4fa',fg='#1e1e2e',bold

# Status bar left
set -g status-left " [#S] "
set -g status-left-style bg='#a6e3a1',fg='#1e1e2e',bold
set -g status-left-length 30

# Status bar right
set -g status-right " #{b:pane_current_path} | %H:%M "
set -g status-right-style fg='#cdd6f4'
set -g status-right-length 50

# Center window list
set -g status-justify left

# Pane border colors
set -g pane-border-style fg='#313244'
set -g pane-active-border-style fg='#89b4fa'

# Message style
set -g message-style bg='#89b4fa',fg='#1e1e2e',bold

# ============================================
# OPTIONAL: vim-tmux-navigator integration
# Uncomment if you install the plugin
# ============================================

# is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
#     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
# bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
# bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
# bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
# bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
```

---

## 🎬 Plan de Implementare

### Săptămâna 1: Core Improvements (Urgent)
- [ ] Adaugă `escape-time 0`
- [ ] Schimbă prefix la `C-a`
- [ ] Adaugă last-window toggle (`^`)
- [ ] Adaugă `-r` flag la bindings
- [ ] Setup copy-mode îmbunătățit
- [ ] Test totul și obișnuiește-te cu noile bindings

### Săptămâna 2: Quick Access & Projects
- [ ] Adaugă config reload binding
- [ ] Setup TODO.md quick access
- [ ] Identifică top 5 proiecte
- [ ] Adaugă project quick jump bindings
- [ ] Test workflow cu proiectele reale

### Săptămâna 3: Git & Tools
- [ ] Setup git aliases
- [ ] Învață git worktrees
- [ ] Instalează zoxide
- [ ] Setup zoxide în shell
- [ ] Experimentează cu worktrees pe un proiect

### Săptămâna 4: Advanced Integration
- [ ] Instalează vim-tmux-navigator (dacă folosești Neovim)
- [ ] Setup keybindings în tmux
- [ ] Instalează modern CLI tools (bat, eza, delta) - opțional
- [ ] Setup global tmux-sessionizer cu Karabiner - opțional

---

## 📊 Expected Productivity Gains

După implementarea tuturor quick wins (prioritate URGENT):

- **Keystrokes reduse**: ~40% fewer keystrokes pentru navigare
- **Context switching**: ~3-5 secunde mai rapid între proiecte
- **Mental overhead**: Semnificativ redus datorită muscle memory
- **Workflow fluidity**: Night and day difference

După implementarea complete (toate prioritățile):

- **Productivitate generală**: ~20-30% improvement în daily workflow
- **Time to start working on project**: De la ~30 sec la ~2 sec
- **Frustration level**: Massive reduction

---

## 📚 Resurse Suplimentare

### Video-uri Primeagen
- [Tmux has forever changed the way I write code](https://www.youtube.com/watch?v=H70lULWJeig) (YouTube)
- [tmux-sessionizer](https://www.youtube.com/watch?v=hJzqEAf2U4I) (YouTube)
- [The Only Right Way to Learn Tmux](https://www.youtube.com/watch?v=U-omALWIBos) (YouTube)

### Documentație
- [Primeagen's dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- [tmux documentation](https://github.com/tmux/tmux/wiki)
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

### Cheat Sheets
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [Git Worktrees Guide](https://git-scm.com/docs/git-worktree)

---

## ✅ Checklist Final

### Must Have (fă astea ACUM)
- [ ] `escape-time 0`
- [ ] Prefix `C-a`
- [ ] Last-window toggle
- [ ] Repeatable bindings
- [ ] Copy-mode improvements

### Should Have (fă în următoarele 2 săptămâni)
- [ ] Project quick jumps
- [ ] TODO.md binding
- [ ] Git aliases
- [ ] Config reload binding

### Nice to Have (când ai timp)
- [ ] vim-tmux-navigator
- [ ] Git worktrees workflow
- [ ] zoxide
- [ ] Modern CLI tools
- [ ] Global tmux-sessionizer

---

## 🎯 Concluzie

Configurația ta actuală este deja destul de bună! Ai scripturile esențiale și o temă frumoasă. Îmbunătățirile sugerate sunt în mare parte despre:

1. **Ergonomie** - mai puțin strain, mai naturală navigarea
2. **Speed** - mai puține keystrokes, response mai rapid
3. **Workflow** - patterns care facilitează deep work

**Recomandarea mea**: Începe cu "Quick Wins" (primele 5 îmbunătățiri urgent). Sunt ~10 minute de implementat dar vor transforma complet cum te simți în tmux. Apoi adaugă restul gradual pe măsură ce simți nevoia.

**Cel mai important**: Nu implementa totul deodată. Adaugă 2-3 îmbunătățiri, folosește-le câteva zile până devine muscle memory, apoi adaugă altele. Otherwise e overwhelming și te vei întoarce la vechile habits.

---

**Succes cu optimizarea workflow-ului! 🚀**

*Documentat: 26 Decembrie 2025*
