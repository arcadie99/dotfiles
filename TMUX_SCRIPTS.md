# ThePrimeagen's Tmux Scripts - Ghid Complet

Acest ghid explică toate scripturile tmux de la ThePrimeagen și cum să le folosești.

---

## 📦 Scripturile Instalate

### 1. **tmux-sessionizer** - Quick Project Switching
**Locație:** `~/.local/scripts/tmux-sessionizer`
**Keybind:** `prefix + f` (Ctrl+B apoi f)

**Ce face:**
- Caută în directoarele tale de proiecte
- Folosește `fzf` pentru fuzzy finding
- Creează sau switch la o sesiune tmux pentru proiectul selectat

**Cum funcționează:**
1. Apasă `prefix + f`
2. Apare fzf cu toate directoarele din:
   - `~/Developer/github/`
   - `~/Developer/mit-dev/code/`
   - `~/Developer/`
   - `~/`
3. Tastează și selectează proiectul
4. Tmux creează o sesiune cu numele proiectului și te duce acolo

**Exemplu workflow:**
```bash
# Ești în sesiune "dotfiles"
# Apasă prefix + f
# Selectezi "my-app" din ~/Developer/github/
# → Tmux creează sesiunea "my-app" și te mută acolo
# → Working directory e automat ~/Developer/github/my-app
```

**Customizare:**
Editează fișierul pentru a adăuga propriile tale directoare:
```bash
nvim ~/.local/scripts/tmux-sessionizer
# Modifică linia cu find pentru a include alte paths
```

---

### 2. **tmux-windowizer** - Git Branch Windows
**Locație:** `~/.local/scripts/tmux-windowizer`
**Keybind:** Nici unul (se folosește din CLI)

**Ce face:**
- Creează o fereastră tmux numită după un git branch
- Rulează comenzi în acea fereastră
- Pentru branches simultane, folosește directoare worktree separate

**Cum funcționează:**
```bash
# Sintaxă
tmux-windowizer <branch-name> <command>

# Exemple practice:

# Creează fereastră pentru feature/login și rulează git status
tmux-windowizer feature/login git status

# Creează fereastră pentru bugfix/auth și pornește server
tmux-windowizer bugfix/auth npm run dev

# Creează fereastră pentru main și rulează tests
tmux-windowizer main npm test
```

**Comportament:**
- Numele complet al branch-ului devine numele ferestrei (`feature/login` → `feature_login`).
- Comanda și argumentele sunt trimise literal, apoi executate cu Enter.
- Fereastra nouă pornește în directorul curent. O fereastră existentă își păstrează directorul.
- Nu face checkout și nu creează worktree: pentru lucru pe alt branch, pregătește mai întâi un worktree și rulează scriptul de acolo.
- Dacă panoul existent rulează alt program decât un shell, scriptul refuză trimiterea comenzii.

---

### 3. **tmux-cht.sh** - Quick Cheat Sheets
**Locație:** `~/.local/scripts/tmux-cht.sh`
**Keybind:** `prefix + i` (Ctrl+B apoi i)

**Ce face:**
- Acces rapid la [cht.sh](https://cht.sh) - cel mai bun cheat sheet pentru programatori
- Caută documentație pentru limbaje și comenzi
- Rezultatele apar în `less`, în fereastra scriptului

**Cum funcționează:**

#### **Pas 1: Selectează limbaj sau comandă**
Apasă `prefix + i` → Apare fzf cu opțiuni:

**Limbaje disponibile:**
- golang, javascript, typescript, python, rust, c, cpp, lua, php, bash, zsh
- html, css, nodejs, tmux, haskell, solidity, gdb

**Comenzi disponibile:**
- git, docker, find, grep, sed, awk, ssh, cargo, make, stow
- ls, mv, cp, rm, tar, jq, chmod, chown

#### **Pas 2: Enter query**
După selectare, tastează întrebarea:

**Exemple pentru limbaje:**
```
Selectezi: python
Query: read file
→ Arată cum să citești fișiere în Python

Selectezi: javascript
Query: async await
→ Exemple de async/await

Selectezi: rust
Query: hashmap
→ Documentație HashMap în Rust
```

**Exemple pentru comenzi:**
```
Selectezi: git
Query: rebase
→ Cum să faci git rebase

Selectezi: docker
Query: compose
→ Docker compose examples

Selectezi: find
Query: name
→ Cum să cauți fișiere după nume
```

#### **Navigare în rezultate:**
- **Scroll:** Arrow keys / j,k
- **Quit:** q
- **Search:** / (slash) apoi tastează

**Workflow practic:**
```bash
# Situație: Scrii Rust și uiți sintaxa pentru Result
1. prefix + i
2. Selectezi "rust"
3. Query: "result error handling"
4. → Fereastră nouă cu exemple și explicații
5. Citești, înțelegi, q pentru ieșire
6. Back to coding!

# Situație: Trebuie să faci git rebase dar nu știi flags
1. prefix + i
2. Selectezi "git-rebase"
3. Query: "interactive"
4. → Vezi toate opțiunile pentru git rebase -i
5. Copy command, q, paste în terminal
```

---

## ⌨️ Toate Keybindings-urile Tmux

### **ThePrimeagen Scripts**
| Key | Comandă | Descriere |
|-----|---------|-----------|
| `prefix + f` | tmux-sessionizer | Switch rapid între proiecte |
| `prefix + i` | tmux-cht.sh | Cheat sheets cht.sh |

### **Pane Navigation (Vim-style)**
| Key | Comandă | Descriere |
|-----|---------|-----------|
| `prefix + h` | select-pane left | Pane stânga |
| `prefix + j` | select-pane down | Pane jos |
| `prefix + k` | select-pane up | Pane sus |
| `prefix + l` | select-pane right | Pane dreapta |

### **Alte Bindings**
| Key | Comandă | Descriere |
|-----|---------|-----------|
| `prefix + y` | display-popup | Arată popup |

**Nota:** `prefix` = `Ctrl+B` (default tmux)

---

## 🚀 Setup Complet - Checklist

### **1. Instalare dependențe**
```bash
# fzf - pentru fuzzy finding
brew install fzf

# curl - pentru cht.sh (de obicei deja instalat)
which curl  # verifică

# Stow (deja instalat)
```

### **2. Make scripts executable**
```bash
cd ~/.dotfiles
chmod +x scripts/.local/scripts/tmux-*
```

### **3. Deploy cu Stow**
```bash
cd ~/.dotfiles
stow scripts  # Creează symlinks în ~/.local/scripts/
stow tmux     # Creează symlinks pentru .tmux.conf și cht files
```

### **4. Verifică că scripturile sunt accesibile**
```bash
# Verifică symlinks
ls -la ~/.local/scripts/

# Ar trebui să vezi:
# tmux-sessionizer -> ~/.dotfiles/scripts/.local/scripts/tmux-sessionizer
# tmux-windowizer -> ~/.dotfiles/scripts/.local/scripts/tmux-windowizer
# tmux-cht.sh -> ~/.dotfiles/scripts/.local/scripts/tmux-cht.sh

# Verifică cht files
ls -la ~/.tmux-cht-*

# Ar trebui să vezi:
# .tmux-cht-languages -> ~/.dotfiles/tmux/.tmux-cht-languages
# .tmux-cht-command -> ~/.dotfiles/tmux/.tmux-cht-command
```

### **5. Reload tmux config**
```bash
# Dacă ești deja în tmux:
prefix + :
source-file ~/.tmux.conf

# SAU restart tmux:
tmux kill-server
tmux
```

### **6. Test scripturile**

**Test tmux-sessionizer:**
```bash
# În tmux, apasă:
prefix + f
# Ar trebui să apară fzf cu directoarele tale
```

**Test tmux-cht.sh:**
```bash
# În tmux, apasă:
prefix + i
# Ar trebui să apară lista de limbaje/comenzi
```

**Test tmux-windowizer:**
```bash
# Din terminal:
~/.local/scripts/tmux-windowizer test-branch echo "Hello"
# Ar trebui să creeze o fereastră nouă "test-branch"
```

---

## 🎯 Workflow-uri Recomandate

### **Workflow 1: Multi-Project Development**
```bash
# Dimineața, începi munca
tmux

# Switch la proiect backend
prefix + f → selectezi "backend-api"

# Deschizi un split pentru frontend
prefix + % (vertical split)
prefix + f → selectezi "frontend-app"

# Acum ai 2 panes cu 2 proiecte diferite
# Switch între ele cu prefix + h/l
```

### **Workflow 2: Git Branch Development**
```bash
# Lucrezi pe feature
git checkout feature/auth

# Vrei să compari cu main
tmux-windowizer main git diff feature/auth

# Vrei să rulezi tests pe staging
tmux-windowizer staging npm test

# Acum ai 3 ferestre:
# 1. feature_auth (work in progress)
# 2. main (comparison)
# 3. staging (tests running)

# Switch: prefix + 1/2/3
```

### **Workflow 3: Learning Mode**
```bash
# Înveți Rust
nvim main.rs

# Uiți sintaxa pentru pattern matching
prefix + i
→ rust
→ pattern matching
→ Citești exemple
→ q
→ Back to nvim, implementezi

# Repeti pentru orice concept nou
```

---

## 🔧 Customization

### **Adaugă propriile tale directoare în sessionizer**

Editează `~/.dotfiles/scripts/.local/scripts/tmux-sessionizer`:

```bash
# Linia cu find, schimb-o în:
selected=$(find ~/work ~/personal ~/projects ~/github -mindepth 1 -maxdepth 1 -type d | fzf)
```

### **Adaugă limbaje noi în cht.sh**

Editează `~/.dotfiles/tmux/.tmux-cht-languages`:
```bash
echo "java" >> ~/.dotfiles/tmux/.tmux-cht-languages
echo "kotlin" >> ~/.dotfiles/tmux/.tmux-cht-languages
echo "swift" >> ~/.dotfiles/tmux/.tmux-cht-languages
```

### **Adaugă comenzi noi**

Editează `~/.dotfiles/tmux/.tmux-cht-command`:
```bash
echo "kubectl" >> ~/.dotfiles/tmux/.tmux-cht-command
echo "terraform" >> ~/.dotfiles/tmux/.tmux-cht-command
```

### **Schimbă keybindings**

Editează `~/.dotfiles/tmux/.tmux.conf`:
```bash
# Schimbă prefix + f în prefix + s (sessionizer)
bind-key -r s run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

# Adaugă binding pentru windowizer
bind-key -r w run-shell "tmux neww ~/.local/scripts/tmux-windowizer"
```

---

## 🐛 Troubleshooting

### **tmux-sessionizer nu găsește directoare**
```bash
# Verifică că fzf e instalat
which fzf

# Verifică că path-urile din script există
ls ~/Developer/github
ls ~/Developer/mit-dev/code

# Editează scriptul cu path-urile tale corecte
```

### **tmux-cht.sh dă eroare "file not found"**
```bash
# Verifică că fișierele cht există
ls -la ~/.tmux-cht-languages
ls -la ~/.tmux-cht-command

# Dacă nu există, rulează stow din nou:
cd ~/.dotfiles
stow tmux
```

### **Keybindings nu funcționează**
```bash
# Reload tmux config
tmux source-file ~/.tmux.conf

# SAU restart tmux complet
tmux kill-server
tmux
```

### **Scripturile nu sunt executabile**
```bash
chmod +x ~/.local/scripts/tmux-*
```

---

## 📚 Resurse Suplimentare

- [cht.sh documentation](https://github.com/chubin/cheat.sh)
- [ThePrimeagen's dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- [fzf documentation](https://github.com/junegunn/fzf)
- [Tmux cheat sheet](https://tmuxcheatsheet.com/)

---

## 💡 Tips & Tricks

1. **Folosește sessionizer frecvent** - E mai rapid decât `cd` + manual tmux session creation
2. **cht.sh e fantastic** - Înlocuiește Google pentru quick syntax lookups
3. **windowizer pentru review-uri** - Perfect când faci code review pe alt branch
4. **Customizează path-urile** - Adaugă toate directoarele tale de work
5. **Învață keybindings** - Muscle memory te face 10x mai rapid

---

**Enjoy the ThePrimeagen workflow! 🚀**

### Actualizări de comportament

- Sessionizer folosește nume cu un sufix derivat din calea canonică, pentru a separa proiectele cu același nume. Sesiunile vechi rămân disponibile prin `tmux attach -t <nume>`.
- Cheatsheet afișează rezultatul în fereastra curentă, în `less` (`q` pentru ieșire); `prefix+i` deschide deja o fereastră pentru script.
- `prefix+r` reîncarcă configurația; `prefix+R` reordonează ferestrele.
- Ferestrele și split-urile noi folosesc directorul panoului activ. Istoricul este de 50.000 de linii pentru panourile noi.
