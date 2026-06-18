# OsakaOaks Website - Automated Dev/Prod Pipeline

Fully automated deployment pipeline for **osakaoaks.org** (production) and **jarrelspiller.osakaoaks.org** (development).

## 🏗️ Architecture

```
Local Development (Cursor IDE)
    ↓
GitHub Repository
    ├── main branch → osakaoaks.org (production)
    └── dev branch  → jarrelspiller.osakaoaks.org (dev)
    ↓
GitHub Actions (auto-deploy on push)
    ↓
cPanel Shared Hosting (Namecheap)
```

## 📋 Server Information

| Field | Value |
|-------|-------|
| **Server IP** | 162.0.215.40 |
| **SSH Host** | osakaoaks.org |
| **SSH Port** | 21098 |
| **Username** | osakuqbj |
| **Production Path** | /home/osakuqbj/public_html/ |
| **Dev Path** | /home/osakuqbj/jarrelspiller.osakaoaks.org/ |

## 🚀 Quick Start

### 1. Download SSH Keys from cPanel

1. Go to cPanel → **Manage Shell** → **Manage SSH Keys**
2. Download these private keys:
   - `rsa_prod_deploy` (Private Keys section)
   - `rsa_dev_deploy` (Private Keys section)
3. Save them to `~/.ssh/` on your Mac:
   ```bash
   mv ~/Downloads/rsa_prod_deploy ~/.ssh/
   mv ~/Downloads/rsa_dev_deploy ~/.ssh/
   chmod 600 ~/.ssh/rsa_prod_deploy
   chmod 600 ~/.ssh/rsa_dev_deploy
   ```

### 2. Configure SSH for Cursor

Copy the SSH config from `ssh-config-template.txt` to `~/.ssh/config`:

```bash
cat ssh-config-template.txt >> ~/.ssh/config
```

### 3. Test SSH Connection

```bash
ssh osakaoaks-prod
# Should connect without password prompt
```

### 4. Set Up GitHub Repository

1. Create a new GitHub repository: `osakaoaks-website`
2. Add GitHub Secrets (Settings → Secrets and Variables → Actions):
   - `SSH_HOST` = `osakaoaks.org`
   - `SSH_USER` = `osakuqbj`
   - `SSH_PORT` = `21098`
   - `SSH_PRIVATE_KEY` = contents of `~/.ssh/rsa_prod_deploy`

### 5. Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit - automated pipeline setup"
git branch -M main
git remote add origin git@github.com:YOUR_USERNAME/osakaoaks-website.git
git push -u origin main
```

### 6. Create Dev Branch

```bash
git checkout -b dev
git push -u origin dev
```

## 🔧 Cursor IDE Remote SSH Setup

1. Install **Remote - SSH** extension in Cursor
2. Press `Cmd+Shift+P` → type "Remote-SSH: Connect to Host"
3. Select `osakaoaks-prod` or `osakaoaks-dev`
4. Open folder:
   - Production: `/home/osakuqbj/public_html`
   - Dev: `/home/osakuqbj/jarrelspiller.osakaoaks.org`

Now you can edit files directly on the server with full Cursor AI features!

## 📝 Workflow

### Development Workflow
```bash
# Work on dev branch
git checkout dev
# Make changes
git add .
git commit -m "Add feature"
git push origin dev
# GitHub Actions auto-deploys to jarrelspiller.osakaoaks.org
```

### Production Deployment
```bash
# Merge dev to main
git checkout main
git merge dev
git push origin main
# GitHub Actions auto-deploys to osakaoaks.org
```

## 🗂️ File Structure

```
OsakaOaks/
├── .github/workflows/
│   ├── deploy-prod.yml    → Auto-deploy to production
│   └── deploy-dev.yml     → Auto-deploy to dev
├── .cpanel.yml            → Production deployment script
├── .cpanel-dev.yml        → Dev deployment script
├── .gitignore             → Excludes sensitive files
└── README.md              → This file
```

## ✅ Checklist

- [ ] Download SSH keys from cPanel
- [ ] Add SSH config to `~/.ssh/config`
- [ ] Test SSH connection
- [ ] Create GitHub repository
- [ ] Add GitHub Actions secrets
- [ ] Push code to GitHub
- [ ] Verify GitHub Actions runs successfully
- [ ] Test dev deployment
- [ ] Test production deployment
- [ ] Set up Cursor Remote SSH

## 🔐 Security Notes

- **NEVER** commit SSH private keys to Git
- Keep `wp-config.php` excluded from Git (it's in `.gitignore`)
- GitHub Actions secrets are encrypted
- SSH keys should have `600` permissions

## 📞 Support

- cPanel: premium187.web-hosting.com
- Username: osakuqbj
- GitHub repo: [Link after creation]
