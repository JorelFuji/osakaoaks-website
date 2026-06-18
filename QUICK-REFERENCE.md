# Quick Reference Card

## 🔑 Server Credentials
- **Host:** osakaoaks.org
- **IP:** 162.0.215.40
- **Port:** 21098
- **User:** osakuqbj
- **cPanel:** https://premium187.web-hosting.com

## 📁 Important Paths
```
Production:  /home/osakuqbj/public_html/
Dev:         /home/osakuqbj/jarrelspiller.osakaoaks.org/
Repos:       /home/osakuqbj/repos/
SSH Keys:    ~/.ssh/ (local) or /home/osakuqbj/.ssh/ (server)
```

## 🔗 Quick Commands

### SSH Connections
```bash
ssh osakaoaks-prod              # Production
ssh osakaoaks-dev               # Dev
ssh osakuqbj@osakaoaks.org -p 21098  # Direct connection
```

### Git Workflow
```bash
# Development
git checkout dev
git add .
git commit -m "message"
git push origin dev

# Production deploy
git checkout main
git merge dev
git push origin main
```

### Server Commands (via SSH)
```bash
# Check production status
ssh osakaoaks-prod "cd public_html && git status"

# Pull latest on server
ssh osakaoaks-prod "cd public_html && git pull origin main"

# Check dev status
ssh osakaoaks-dev "cd jarrelspiller.osakaoaks.org && git status"
```

## 🚀 Deploy Process
1. **Make changes** on `dev` branch
2. **Test** at jarrelspiller.osakaoaks.org
3. **Merge** to `main` when ready
4. **Auto-deploys** to osakaoaks.org via GitHub Actions

## 🛠️ Helper Scripts
```bash
./scripts/setup-ssh.sh          # Configure SSH keys and config
./scripts/verify-deployment.sh  # Check deployment status
```

## 🔧 Cursor Remote SSH
1. `Cmd+Shift+P`
2. "Remote-SSH: Connect to Host"
3. Choose `osakaoaks-prod` or `osakaoaks-dev`
4. Open folder: `/home/osakuqbj/public_html` or `/home/osakuqbj/jarrelspiller.osakaoaks.org`

## 🔐 GitHub Secrets Required
- `SSH_HOST` = osakaoaks.org
- `SSH_USER` = osakuqbj
- `SSH_PORT` = 21098
- `SSH_PRIVATE_KEY` = contents of rsa_prod_deploy

## 🌐 URLs
- **Production:** https://osakaoaks.org
- **Dev:** https://jarrelspiller.osakaoaks.org
- **GitHub:** [Your repo URL]
- **cPanel:** https://premium187.web-hosting.com:2083

## 📞 SSH Key Names
- `rsa_prod_deploy` - Production deployment
- `rsa_dev_deploy` - Dev deployment
- `OsakaOakssshcpanel` - General cPanel access
- `vs-code` - VS Code/Cursor IDE (needs authorization)

## 🆘 Emergency Commands
```bash
# Revert production to previous commit
ssh osakaoaks-prod "cd public_html && git reset --hard HEAD~1"

# Force pull from GitHub
ssh osakaoaks-prod "cd public_html && git fetch origin && git reset --hard origin/main"

# Check what's running
ssh osakaoaks-prod "ps aux | grep node"

# Check disk space
ssh osakaoaks-prod "df -h"
```

## ✅ Pre-Push Checklist
- [ ] Tested on dev environment
- [ ] No sensitive data in commit
- [ ] WordPress config excluded (.gitignore)
- [ ] Commit message is descriptive
- [ ] On correct branch (dev or main)
