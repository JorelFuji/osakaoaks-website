# 🔄 Replace WordPress with New Osaka Oaks Website

## 📋 Overview

This guide will help you:
1. ✅ **Archive** your current WordPress site (osakaoaks.org)
2. ✅ **Move** it to safe storage (~/archived-wordpress/)
3. ✅ **Deploy** new static Osaka Oaks website to public_html
4. ✅ **Preserve** ability to restore WordPress if needed

---

## ⚠️ What Will Happen

### Before (Current):
```
public_html/
├── WordPress Installation
│   ├── wp-admin/
│   ├── wp-content/
│   ├── wp-includes/
│   ├── wp-config.php
│   └── ... (all WordPress files)
```

### After (New Site):
```
public_html/
├── index.html          # New Osaka Oaks homepage
├── css/
├── js/
├── images/
└── .htaccess

archived-wordpress/TIMESTAMP/
├── wordpress-files.tar.gz    # Complete backup
├── database.sql.gz           # Database backup
├── file-manifest.txt         # List of files
└── restore-instructions.txt  # How to restore
```

---

## 🚀 Deploy in One Command

### Run the Archive & Deploy Script:

```bash
cd /Users/m1876041/Documents/Github/OsakaOaks
./scripts/archive-wp-deploy-new-site.sh
```

**The script will:**
1. ✅ Analyze current WordPress installation
2. ✅ Backup database (MySQL dump)
3. ✅ Archive all files (.tar.gz)
4. ✅ Create file manifest
5. ✅ Generate restore instructions
6. ✅ Clear public_html (WordPress removed)
7. ✅ Deploy new static website
8. ✅ Set secure permissions
9. ✅ Verify deployment

**Duration:** ~2-5 minutes depending on site size

---

## 📊 What Gets Archived

### Database:
- Complete MySQL dump
- Saved as: `database.sql.gz`
- Includes all posts, pages, users, settings

### Files:
- All WordPress core files
- All themes
- All plugins
- All uploads (media library)
- All custom files
- wp-config.php (database credentials)

### Excluded (not backed up):
- Temporary files (*.tmp)
- Log files (*.log)
- Cache files

---

## 🔐 Archive Location

```
~/archived-wordpress/20260618_150000/
├── wordpress-files.tar.gz       (All files)
├── database.sql.gz              (Database)
├── file-manifest.txt            (List of files)
├── restore-instructions.txt     (Restore guide)
└── README.txt                   (Archive info)
```

**Archive will be saved with timestamp, for example:**
- Date: June 18, 2026 at 3:00 PM
- Location: `~/archived-wordpress/20260618_150000/`

---

## ✅ Safety Features

### Multiple Safeguards:
1. **Confirmation Required** - Script asks "Type YES to continue"
2. **Complete Backup** - Everything archived before deletion
3. **Database Backup** - MySQL dump created
4. **File Manifest** - List of all archived files
5. **Restore Instructions** - Clear guide to undo changes
6. **No Auto-Delete** - Archives kept indefinitely

### What's Preserved:
- `.git` folder (if exists)
- `.ssh` keys
- Hidden config files
- Environment variables
- Bash history

---

## 🎯 New Website Features

After deployment, you'll have:

### Modern Static Website:
- ✅ Professional design
- ✅ Mobile responsive
- ✅ Fast loading (no database queries)
- ✅ Secure (HTTPS, headers)
- ✅ Contact form (FormSubmit.co)
- ✅ Easy to update (just edit HTML)

### Pages Included:
- Home (Hero section)
- About
- Services (6 service cards)
- Contact form

### Contact Form:
- Sends to: jorel@osakaoaks.org
- No PHP required
- Spam protection
- Free forever

---

## 🔄 How to Restore WordPress (If Needed)

### Quick Restore:

```bash
# 1. SSH into server
ssh osakuqbj@osakaoaks.org -p 21098

# 2. Go to archive directory
cd ~/archived-wordpress/TIMESTAMP/

# 3. Read restore instructions
cat restore-instructions.txt

# 4. Restore files
cd ~/public_html
tar -xzf ~/archived-wordpress/TIMESTAMP/wordpress-files.tar.gz

# 5. Restore database
gunzip ~/archived-wordpress/TIMESTAMP/database.sql.gz
mysql -u DB_USER -p DB_NAME < database.sql

# 6. Done!
```

**Restoration time:** ~5 minutes

---

## 📝 Step-by-Step Execution

### Step 1: Review Current Site (Optional)
```bash
ssh osakuqbj@osakaoaks.org -p 21098
cd ~/public_html
ls -la
```

### Step 2: Run Archive & Deploy Script
```bash
cd /Users/m1876041/Documents/Github/OsakaOaks
./scripts/archive-wp-deploy-new-site.sh
```

**You'll see:**
```
╔════════════════════════════════════════╗
║  Archive WordPress & Deploy New Site  ║
╚════════════════════════════════════════╝

⚠️  WARNING: This will:
   1. Archive WordPress from public_html
   2. Move to ~/archived-wordpress/
   3. Deploy new static website

Type 'YES' to continue:
```

Type: **YES**

### Step 3: Watch Progress
The script will show:
- ✅ Analyzing current site
- ✅ Creating archive directory
- ✅ Backing up database
- ✅ Archiving files
- ✅ Clearing public_html
- ✅ Deploying new site
- ✅ Setting permissions

### Step 4: Verify New Site
```bash
# Check website
curl -I https://osakaoaks.org

# Or visit in browser
open https://osakaoaks.org
```

---

## 🧪 Test Before Production (Recommended)

Want to test first? Use dev environment:

```bash
# Deploy to dev site first
ssh osakuqbj@osakaoaks.org -p 21098

# Archive dev WordPress
cd ~/jarrelspiller.osakaoaks.org
# ... backup steps

# Deploy to dev
rsync -avz website/ ~/jarrelspiller.osakaoaks.org/

# Test at: https://jarrelspiller.osakaoaks.org
```

If satisfied, run production script.

---

## 📊 Comparison: WordPress vs Static

| Feature | WordPress | New Static Site |
|---------|-----------|----------------|
| Speed | Slow (database) | ⚡ Fast |
| Security | Needs updates | 🔒 Minimal attack surface |
| Maintenance | Weekly updates | ✅ Zero maintenance |
| Editing | Admin panel | 📝 Edit HTML/CSS |
| Performance | Variable | ⚡ Always fast |
| Hosting | PHP + MySQL | 🌐 Any server |
| Cost | More resources | 💰 Minimal resources |
| Backup | Complex | 📁 Simple files |

---

## 🛡️ What If Something Goes Wrong?

### Scenario 1: Script Fails During Backup
- **Status:** WordPress still intact
- **Action:** Review error, run script again
- **Risk:** None (nothing deleted yet)

### Scenario 2: Script Fails During Deploy
- **Status:** Backup exists, public_html empty
- **Action:** Restore from archive
- **Risk:** Low (backup complete before deletion)

### Scenario 3: New Site Doesn't Work
- **Status:** Old site archived
- **Action:** Restore WordPress from archive
- **Risk:** None (5-minute restore)

### Scenario 4: Need WordPress Back Later
- **Status:** New site running
- **Action:** Extract archive, restore database
- **Risk:** None (archives kept forever)

---

## 💾 Archive Management

### Check Archives:
```bash
ssh osakuqbj@osakaoaks.org -p 21098
ls -lh ~/archived-wordpress/
```

### View Archive Contents:
```bash
cd ~/archived-wordpress/TIMESTAMP/
cat README.txt
tar -tzf wordpress-files.tar.gz | head -20
```

### Delete Old Archives (Optional):
```bash
# Keep only most recent 3 archives
cd ~/archived-wordpress/
ls -t | tail -n +4 | xargs rm -rf
```

---

## 🎨 Customize New Website

After deployment, customize by editing:

### Edit Content:
```bash
# Edit locally
cd /Users/m1876041/Documents/Github/OsakaOaks/website
code index.html  # or open in Cursor

# Change company info, services, about section
# Commit and push to deploy
git add .
git commit -m "Update website content"
git push origin main
```

### Add Images:
```bash
# Add to website/images/ folder
cp your-image.jpg website/images/
git add website/images/
git commit -m "Add images"
git push
```

### Change Colors:
Edit `website/css/styles.css` lines 7-10

---

## 🚨 Important Notes

### Before Running Script:
- [ ] Verify you have SSH access
- [ ] Check disk space: `df -h`
- [ ] Confirm backup email works
- [ ] Review new website files in `website/`

### After Running Script:
- [ ] Test new website works
- [ ] Test contact form
- [ ] Verify SSL/HTTPS working
- [ ] Check mobile responsiveness
- [ ] Save archive location

### WordPress Archive:
- ✅ Archives kept indefinitely
- ✅ Can restore anytime
- ✅ Full database + files
- ✅ Restore instructions included

---

## 📞 Need Help?

**Issues during archive/deploy?**
- Archive location: `~/archived-wordpress/TIMESTAMP/`
- Check script output for errors
- Restore instructions in archive folder

**Questions?**
- Email: jorel@osakaoaks.org
- Review: `NO-PHP-SETUP.md` for new site details

---

## ✅ Ready to Deploy?

### Run this command:

```bash
cd /Users/m1876041/Documents/Github/OsakaOaks
./scripts/archive-wp-deploy-new-site.sh
```

**What happens:**
1. Script runs (2-5 minutes)
2. WordPress archived safely
3. New website deployed
4. You're live! 🎉

**Your new site:** https://osakaoaks.org

---

## 🎉 After Deployment

### Immediately:
1. Visit https://osakaoaks.org
2. Test navigation
3. Submit contact form (confirm email first time)
4. Check mobile version

### Within 24 hours:
1. Monitor email for form submissions
2. Check Google Analytics (if added)
3. Test from different browsers
4. Share with team/clients

### Long term:
1. Update content as needed (edit HTML, git push)
2. Keep archives for reference
3. Monitor website performance
4. Add features as needed

---

**Ready?** Run the script now! 🚀
