# Complete Setup Guide - Step by Step

Follow these steps in order to set up your automated pipeline.

## Phase 1: SSH Access Setup (15 minutes)

### Step 1: Download Private Keys from cPanel

1. Log into cPanel at https://premium187.web-hosting.com
2. Navigate to **Advanced** → **Manage Shell** → **Manage SSH Keys**
3. Scroll to **Private Keys** section
4. Click **View/Download** for these keys:
   - `rsa_prod_deploy`
   - `rsa_dev_deploy`
5. Save the downloaded files

### Step 2: Install Keys on Your Mac

Open Terminal and run:

```bash
# Move keys to SSH folder
mv ~/Downloads/rsa_prod_deploy ~/.ssh/
mv ~/Downloads/rsa_dev_deploy ~/.ssh/

# Set correct permissions (required!)
chmod 600 ~/.ssh/rsa_prod_deploy
chmod 600 ~/.ssh/rsa_dev_deploy

# Verify they're there
ls -la ~/.ssh/
```

### Step 3: Add SSH Configuration

```bash
# Open or create SSH config
nano ~/.ssh/config
```

Add this configuration (from `ssh-config-template.txt`):

```
Host osakaoaks-prod
    HostName osakaoaks.org
    User osakuqbj
    Port 21098
    IdentityFile ~/.ssh/rsa_prod_deploy
    ServerAliveInterval 60
    ServerAliveCountMax 3

Host osakaoaks-dev
    HostName osakaoaks.org
    User osakuqbj
    Port 21098
    IdentityFile ~/.ssh/rsa_dev_deploy
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

Save with `Ctrl+O`, `Enter`, then `Ctrl+X`

### Step 4: Test SSH Connection

```bash
ssh osakaoaks-prod
```

If successful, you'll see:
```
osakuqbj@premium187 [~]#
```

Type `exit` to disconnect.

✅ **Checkpoint:** SSH access working without password prompt

---

## Phase 2: GitHub Setup (10 minutes)

### Step 5: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `osakaoaks-website`
3. Set to **Private** (recommended for production sites)
4. **Do NOT** initialize with README (we already have files)
5. Click **Create repository**

### Step 6: Add GitHub Actions Secrets

1. Go to your new repo → **Settings** tab
2. Click **Secrets and variables** → **Actions**
3. Click **New repository secret** for each:

| Name | Value |
|------|-------|
| `SSH_HOST` | `osakaoaks.org` |
| `SSH_USER` | `osakuqbj` |
| `SSH_PORT` | `21098` |
| `SSH_PRIVATE_KEY` | *[full contents of ~/.ssh/rsa_prod_deploy file]* |

To get the private key content:
```bash
cat ~/.ssh/rsa_prod_deploy
```
Copy everything from `-----BEGIN RSA PRIVATE KEY-----` to `-----END RSA PRIVATE KEY-----` (inclusive).

✅ **Checkpoint:** All 4 secrets added to GitHub

---

## Phase 3: Link Server to GitHub (15 minutes)

### Step 7: Connect Server Git to GitHub

SSH into your production server:

```bash
ssh osakaoaks-prod
```

Then run these commands:

```bash
# Navigate to production folder
cd ~/public_html

# Check Git status
git status

# Add GitHub as remote (replace YOUR_USERNAME)
git remote add origin git@github.com:YOUR_USERNAME/osakaoaks-website.git

# Or if remote already exists, update it:
git remote set-url origin git@github.com:YOUR_USERNAME/osakaoaks-website.git

# Create .cpanel.yml file
cat > .cpanel.yml << 'EOF'
---
deployment:
  tasks:
    - export DEPLOYPATH=/home/osakuqbj/public_html/
    - /bin/cp -R * $DEPLOYPATH
    - /bin/cp -R .htaccess $DEPLOYPATH 2>/dev/null || true
EOF

# Add and commit
git add .cpanel.yml
git commit -m "Add cPanel deployment config"

# Push to GitHub
git push -u origin main
```

### Step 8: Set Up Dev Environment

While still connected via SSH:

```bash
# Navigate to dev folder
cd ~/jarrelspiller.osakaoaks.org

# Initialize Git
git init

# Add remote (same repo, different branch)
git remote add origin git@github.com:YOUR_USERNAME/osakaoaks-website.git

# Create dev branch
git checkout -b dev

# Create .cpanel.yml for dev
cat > .cpanel.yml << 'EOF'
---
deployment:
  tasks:
    - export DEPLOYPATH=/home/osakuqbj/jarrelspiller.osakaoaks.org/
    - /bin/cp -R * $DEPLOYPATH
    - /bin/cp -R .htaccess $DEPLOYPATH 2>/dev/null || true
EOF

# Add, commit, and push
git add .
git commit -m "Initial dev environment setup"
git push -u origin dev
```

Exit SSH: `exit`

✅ **Checkpoint:** Both prod and dev connected to GitHub

---

## Phase 4: Cursor IDE Setup (10 minutes)

### Step 9: Install Remote SSH in Cursor

1. Open Cursor IDE
2. Press `Cmd+Shift+X` (Extensions)
3. Search for "Remote - SSH"
4. Install the one by Microsoft

### Step 10: Connect to Server via Cursor

1. Press `Cmd+Shift+P`
2. Type "Remote-SSH: Connect to Host"
3. Select `osakaoaks-prod`
4. Wait for connection (Cursor installs server components first time)
5. Click **Open Folder**
6. Navigate to `/home/osakuqbj/public_html`
7. Click **OK**

You're now editing live on the server! 🎉

### Step 11: Open Dev Environment in New Window

1. Press `Cmd+Shift+P`
2. Type "Remote-SSH: Connect to Host in New Window"
3. Select `osakaoaks-dev`
4. Open folder: `/home/osakuqbj/jarrelspiller.osakaoaks.org`

✅ **Checkpoint:** Cursor connected to both prod and dev servers

---

## Phase 5: Test the Pipeline (10 minutes)

### Step 12: Test Dev Deployment

In Cursor (connected to dev server):

1. Open or create a test file: `test.txt`
2. Add content: "Dev deployment test"
3. Open integrated terminal (`Cmd+`~`)
4. Run:
   ```bash
   git add test.txt
   git commit -m "Test dev deployment"
   git push origin dev
   ```
5. Go to GitHub → **Actions** tab
6. Watch the "Deploy to Dev" workflow run
7. Verify at https://jarrelspiller.osakaoaks.org/test.txt

### Step 13: Test Production Deployment

In Cursor (connected to prod server):

1. Switch to main branch: `git checkout main`
2. Create `prod-test.txt`
3. Run:
   ```bash
   git add prod-test.txt
   git commit -m "Test prod deployment"
   git push origin main
   ```
4. Watch GitHub Actions
5. Verify at https://osakaoaks.org/prod-test.txt

✅ **Checkpoint:** Both deployments working automatically!

---

## Phase 6: Daily Workflow (Reference)

### Develop on Dev Branch

```bash
# Make sure you're on dev
git checkout dev

# Make changes in Cursor...

# Commit and push
git add .
git commit -m "Add new feature"
git push origin dev

# Auto-deploys to jarrelspiller.osakaoaks.org
```

### Deploy to Production

```bash
# Switch to main
git checkout main

# Merge tested dev changes
git merge dev

# Push to trigger production deployment
git push origin main

# Auto-deploys to osakaoaks.org
```

---

## Troubleshooting

### SSH Connection Refused
```bash
# Test connection manually
ssh -v osakuqbj@osakaoaks.org -p 21098

# Check if key is correct
ls -la ~/.ssh/rsa_prod_deploy
# Should show: -rw------- (600 permissions)
```

### GitHub Actions Failing
1. Check GitHub → Actions → click failed run
2. Common issues:
   - Wrong SSH_PRIVATE_KEY format (must include BEGIN/END lines)
   - Wrong SSH_PORT (must be 21098, not 22)
   - Server Git not configured

### Cursor Won't Connect
1. Check SSH works in Terminal first
2. Make sure Remote SSH extension is installed
3. Try "Remote-SSH: Kill VS Code Server on Host" then reconnect

---

## 🎉 Setup Complete!

You now have:
- ✅ Cursor IDE connected to both environments
- ✅ Git version control on server
- ✅ GitHub Actions auto-deployment
- ✅ Separate dev and production environments
- ✅ Full file manager access via Cursor Remote SSH

**Next:** Start developing on the `dev` branch, test at jarrelspiller.osakaoaks.org, then merge to `main` for production!
