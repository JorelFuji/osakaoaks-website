# 🖥️ Cursor Remote SSH - File Explorer Guide

## How to Browse Server Files in Cursor

### Method 1: Quick Connect (Recommended)

1. **Open Command Palette**
   - Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)

2. **Type**: `Remote-SSH: Connect to Host`

3. **Select**: `osakaoaks-prod` (for production) or `osakaoaks-dev` (for dev)

4. **Wait**: Cursor will connect and install server components (~30 seconds first time)

5. **Open Folder**:
   - Click **"Open Folder"** button that appears
   - Or press `Cmd+K Cmd+O`
   - Navigate to:
     - **Production**: `/home/osakuqbj/public_html`
     - **Dev**: `/home/osakuqbj/jarrelspiller.osakaoaks.org`

6. **Done!** File Explorer will show all server files

---

### Method 2: Using Remote Explorer Panel

1. **Click Remote Explorer Icon** in left sidebar (computer with plug icon)

2. **Find SSH Targets** section

3. **Click folder icon** next to `osakaoaks-prod`

4. **Select folder** when prompted

---

### Method 3: Command Line in Cursor

1. Press `Cmd+Shift+P`
2. Type: `Remote-SSH: Connect to Host...`
3. Type: `osakuqbj@osakaoaks.org -p 21098`
4. Enter password if prompted (or it should use your SSH key)

---

## 📁 What You'll See

Once connected, your File Explorer will show:

```
EXPLORER (Remote)
├── .cpanel/
├── .git/
├── public_html/          ← Production site
│   ├── wp-admin/
│   ├── wp-content/
│   │   ├── themes/
│   │   ├── plugins/
│   │   └── uploads/
│   ├── wp-config.php
│   └── index.php
├── jarrelspiller.osakaoaks.org/  ← Dev site
├── .ssh/
└── other server files...
```

---

## ✨ Features Once Connected

### File Explorer Benefits:
- ✅ **Browse all files** visually
- ✅ **Edit files directly** on server
- ✅ **Drag & drop** files
- ✅ **Search across all files** (`Cmd+Shift+F`)
- ✅ **Git integration** in Source Control panel
- ✅ **Terminal** opens on server (`Cmd+`~`)
- ✅ **Full Cursor AI** features work on server files

### Split View (Edit Both Prod & Dev):
1. Connect to `osakaoaks-prod` in current window
2. Press `Cmd+Shift+P` → `Remote-SSH: Connect to Host in New Window`
3. Select `osakaoaks-dev`
4. Now you have 2 windows - one for prod, one for dev!

---

## 🔍 Quick Actions

### Search All Files on Server
- `Cmd+P` - Quick file search
- `Cmd+Shift+F` - Search file contents

### Open Integrated Terminal
- `Cmd+`~` - Opens terminal directly on server
- Already in correct directory
- Run commands like: `ls -la`, `git status`, `wp-cli`, etc.

### Edit Multiple Files
- Click any file in Explorer to edit
- Changes save directly to server
- Use `Cmd+S` to save

---

## 🛠️ Troubleshooting

### "Could not establish connection"
```bash
# Test SSH manually first:
ssh osakaoaks-prod

# If this works, Cursor should work too
```

### "Permission denied"
```bash
# Check SSH key permissions:
ls -la ~/.ssh/id_rsa_prod

# Should be: -rw------- (600)
# Fix with:
chmod 600 ~/.ssh/id_rsa_prod
```

### "Host key verification failed"
```bash
# Accept the host key:
ssh osakaoaks-prod
# Type 'yes' when prompted
```

---

## 📌 Quick Reference

| Action | Command |
|--------|---------|
| Connect to server | `Cmd+Shift+P` → "Remote-SSH: Connect" |
| Open folder | `Cmd+K Cmd+O` |
| File search | `Cmd+P` |
| Content search | `Cmd+Shift+F` |
| New terminal | `Cmd+`~` |
| Disconnect | `Cmd+Shift+P` → "Remote-SSH: Close Remote Connection" |

---

## 🎯 Your Server Paths

| Environment | Path |
|-------------|------|
| **Production** | `/home/osakuqbj/public_html/` |
| **Dev** | `/home/osakuqbj/jarrelspiller.osakaoaks.org/` |
| **Home** | `/home/osakuqbj/` |
| **SSH Keys** | `/home/osakuqbj/.ssh/` |

---

## 🚀 Pro Tips

1. **Bookmark frequently edited files**: Right-click → "Add to Favorites"
2. **Use Cursor AI**: AI features work on server files too
3. **Multi-cursor editing**: `Cmd+D` to select next occurrence
4. **Git in sidebar**: Source Control panel shows server Git status
5. **Live editing**: Changes are instant - no need to upload/download

---

**Ready to connect?** Press `Cmd+Shift+P` and type `Remote-SSH: Connect to Host`!
