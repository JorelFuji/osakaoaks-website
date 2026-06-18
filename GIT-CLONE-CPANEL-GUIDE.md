# 📦 Git Clone & cPanel File Manager Guide

## ✅ What Was Just Done

Your cPanel files have been cloned to your local machine!

### Cloned Directories:

```
/Users/m1876041/Documents/Github/
├── osakaoaks-production/       ← Git repo (config files only)
├── osakaoaks-dev/              ← Git repo (config files only)
└── osakaoaks-production-wp/    ← Full WordPress files (rsync)
```

---

## 📂 Three Ways to Access Your Files

### Option 1: Full WordPress Clone (Best for Development)
**Location**: `/Users/m1876041/Documents/Github/osakaoaks-production-wp/`

This contains **all** your WordPress files including:
- `wp-content/themes/` - Your themes
- `wp-content/plugins/` - All plugins
- `wp-content/uploads/` - Media files
- `wp-config.php` - Database configuration
- All WordPress core files

**Commands:**
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production-wp
ls -la
```

### Option 2: Git Repository (Best for Version Control)
**Location**: `/Users/m1876041/Documents/Github/osakaoaks-production/`

This is the Git-tracked version (currently only config files).

**Commands:**
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production
git status
git log
```

### Option 3: Remote SSH in Cursor (Best for Live Editing)
Use Cursor Remote SSH to edit files directly on the server (see previous guide).

---

## 🔄 Sync Commands

### Pull Latest Changes from Server

#### Using Git (for tracked files):
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production
git pull origin main
```

#### Using rsync (for all WordPress files):
```bash
rsync -avz -e "ssh -p 21098" \
  --exclude='.git' \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/ \
  /Users/m1876041/Documents/Github/osakaoaks-production-wp/
```

### Push Changes to Server

#### Using Git:
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production
git add .
git commit -m "Your changes"
git push origin main
# GitHub Actions will auto-deploy
```

#### Using rsync (manual):
```bash
rsync -avz -e "ssh -p 21098" \
  /Users/m1876041/Documents/Github/osakaoaks-production-wp/ \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/
```

---

## 🗂️ File Manager Access Methods

### Method 1: Finder (macOS File Browser)
```bash
open /Users/m1876041/Documents/Github/osakaoaks-production-wp
```
Browse files visually in Finder.

### Method 2: Cursor IDE
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production-wp
cursor .
```
Or: Open Cursor → File → Open Folder → select the directory

### Method 3: VS Code
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production-wp
code .
```

### Method 4: Terminal
```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production-wp
ls -la                    # List all files
find . -name "*.php"      # Find PHP files
tree -L 2                 # View directory tree
```

---

## 📝 Common Tasks

### Clone Dev Environment
```bash
rsync -avz -e "ssh -p 21098" \
  osakuqbj@osakaoaks.org:/home/osakuqbj/jarrelspiller.osakaoaks.org/ \
  /Users/m1876041/Documents/Github/osakaoaks-dev-wp/
```

### Update Only Specific Folder (e.g., themes)
```bash
rsync -avz -e "ssh -p 21098" \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/wp-content/themes/ \
  /Users/m1876041/Documents/Github/osakaoaks-production-wp/wp-content/themes/
```

### Push Only Theme Changes
```bash
rsync -avz -e "ssh -p 21098" \
  /Users/m1876041/Documents/Github/osakaoaks-production-wp/wp-content/themes/ \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/wp-content/themes/
```

### Create a Backup Before Changes
```bash
rsync -avz -e "ssh -p 21098" \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/ \
  ~/Documents/Backups/osakaoaks-backup-$(date +%Y%m%d)/
```

---

## 🔐 Git Track WordPress Files (Optional)

If you want to track WordPress files in Git:

```bash
cd /Users/m1876041/Documents/Github/osakaoaks-production-wp
git init
git remote add origin https://github.com/JorelFuji/osakaoaks-website.git

# Add .gitignore for WordPress
cat > .gitignore << 'EOF'
wp-config.php
wp-content/uploads/
wp-content/cache/
.htaccess
error_log
EOF

git add .
git commit -m "Initial WordPress clone"
git push origin main
```

⚠️ **Warning**: Don't commit `wp-config.php` (has database passwords)

---

## 🎯 Recommended Workflow

### For Theme/Plugin Development:
1. **Clone files locally**: ✅ Done
2. **Edit in Cursor/VS Code**: Edit theme files locally
3. **Test locally**: Use Local by Flywheel or MAMP
4. **Push via rsync**: Upload only changed files
5. **Or use Git**: Commit and push, GitHub Actions deploys

### For Quick Edits:
1. **Use Cursor Remote SSH**: Edit directly on server
2. **See changes instantly**: No upload needed

### For Major Changes:
1. **Clone to local**: ✅ Done
2. **Make changes**: Test locally
3. **Git commit**: Track changes
4. **Push to GitHub**: Triggers deployment
5. **Verify**: Check live site

---

## 🛠️ Useful Scripts

### Quick Sync Script
Create: `~/sync-osakaoaks.sh`
```bash
#!/bin/bash
echo "🔄 Syncing from server..."
rsync -avz -e "ssh -p 21098" \
  --progress \
  --exclude='*.log' \
  --exclude='wp-content/cache/' \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/ \
  /Users/m1876041/Documents/Github/osakaoaks-production-wp/
echo "✅ Sync complete!"
```

Make executable: `chmod +x ~/sync-osakaoaks.sh`
Run: `~/sync-osakaoaks.sh`

### Quick Push Script
Create: `~/push-osakaoaks.sh`
```bash
#!/bin/bash
echo "⬆️  Pushing to server..."
rsync -avz -e "ssh -p 21098" \
  --progress \
  --exclude='.git' \
  /Users/m1876041/Documents/Github/osakaoaks-production-wp/ \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/
echo "✅ Push complete!"
```

---

## 📊 Current Status

| Location | Path | Purpose |
|----------|------|---------|
| **Local Git** | `~/Documents/Github/osakaoaks-production` | Version control |
| **Local WordPress** | `~/Documents/Github/osakaoaks-production-wp` | Full WP clone |
| **Server Production** | `/home/osakuqbj/public_html/` | Live site |
| **Server Dev** | `/home/osakuqbj/jarrelspiller.osakaoaks.org/` | Dev site |

---

## 🔗 Quick Commands Reference

```bash
# Navigate to WordPress files
cd /Users/m1876041/Documents/Github/osakaoaks-production-wp

# Pull from server
rsync -avz -e "ssh -p 21098" osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/ .

# Push to server
rsync -avz -e "ssh -p 21098" . osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/

# Open in Finder
open .

# Open in Cursor
cursor .

# List files
ls -la

# Search for file
find . -name "header.php"

# Search in files
grep -r "osakaoaks" .
```

---

**You now have full local access to all your cPanel files!** 🎉
