# Dotfiles Management — Bare Git Repository Method

This guide documents the **Bare Repository** technique for tracking your dotfiles directly in your home directory *without* using symlinks. It treats your `$HOME` as the working tree while keeping Git data in a hidden folder.

---

## 🧠 Concept

- Git repository lives in: `~/.cfg`
- Working tree is: `$HOME`
- You use an alias (`config`) instead of `git`
- No symlinks. No clutter. No nonsense.

---

## 🚀 1. Initial Setup (Current Machine)

### Step 1 — Initialize the bare repository

```bash
git init --bare $HOME/.cfg
```

---

### Step 2 — Create a temporary alias

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

---

### Step 3 — Hide untracked files by default (safety switch)

```bash
config config --local status.showUntrackedFiles no
```

---

### Step 4 — Make the alias permanent

Add it to your shell config:

```bash
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
```

---

### Step 5 — Connect to GitHub

```bash
config remote add origin <YOUR_GITHUB_REPO_URL>
config push -u origin main
```

---

## 🛠 2. Daily Usage

Use `config` exactly like `git`.

```bash
config status                       # Check status
config add .zshrc                   # Track a new file
config commit -m "Update zshrc"     # Commit changes
config push                         # Push to GitHub
config restore --staged <file>      # Unstage a file
```

---

## 💻 3. New Machine Setup (Restoration)

### Prerequisites

- Git installed
- SSH access to GitHub configured

---

### Step 1 — Clone the bare repo

```bash
git clone --bare <YOUR_GITHUB_REPO_URL> $HOME/.cfg
```

---

### Step 2 — Define the alias temporarily

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

---

### Step 3 — Checkout your dotfiles

```bash
config checkout
```

---

## ⚠️ Troubleshooting: Checkout Conflicts

If you see:

```
error: The following untracked working tree files would be overwritten by checkout:
  .zshrc
```

It means the OS already created that file. Remove or move it:

```bash
rm .zshrc
config checkout
```

---

### Step 4 — Re-enable safety switch

```bash
config config --local status.showUntrackedFiles no
```

---

### Step 5 — Restart your terminal

Your restored `.zshrc` and environment should now be active.

---

## 🧪 Pro Tip

You can version-control **any** file in `$HOME`, including:

- `.gitconfig`
- `.zshrc`, `.bashrc`
- `.config/nvim/`
- `.ssh/config` (careful with secrets)

Treat your environment like infrastructure. Because it is.

---

