# 🚀 Website Deployment Guide

## 📋 Overview

This guide will help you deploy the professional Osaka Oaks website with:
- ✅ Modern, responsive design
- ✅ Secure contact form
- ✅ CI/CD automated deployment
- ✅ Automated backups
- ✅ Security measures

---

## 📁 Website Structure

```
website/
├── index.html              # Main homepage
├── css/
│   └── styles.css         # All styling
├── js/
│   └── main.js            # JavaScript functionality
├── api/
│   └── contact.php        # Contact form handler
├── images/                 # Images folder
└── logs/                   # Contact form logs
```

---

## 🔧 Setup Steps

### Step 1: Enable SSL Certificate (HTTPS)

1. Go to cPanel → Security → SSL/TLS Certificates
2. Click "Manage SSL sites"
3. Select "Let's Encrypt" for free SSL
4. Enable SSL for osakaoaks.org
5. Force HTTPS redirect

**Add to .htaccess:**
```apache
# Force HTTPS
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

### Step 2: Configure Email for Contact Form

1. Go to cPanel → Email → Email Accounts
2. Create email: `jorel@osakaoaks.org` (already exists)
3. Verify email works by sending test email

### Step 3: Deploy Website Files

**Option A: Via Git (Automated - Recommended)**
```bash
cd /Users/m1876041/Documents/Github/OsakaOaks
git add website/
git commit -m "Add professional website"
git push origin main
# GitHub Actions will auto-deploy
```

**Option B: Manual via cPanel File Manager**
1. Go to cPanel → Files → File Manager
2. Navigate to `/home/osakuqbj/public_html/`
3. Upload all files from `website/` folder
4. Set permissions:
   - Files: 644
   - Directories: 755
   - contact.php: 644

**Option C: Via SSH/Rsync**
```bash
rsync -avz -e "ssh -p 21098" \
  website/ \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/
```

### Step 4: Create Required Directories

SSH into server and create:
```bash
ssh osakuqbj@osakaoaks.org -p 21098
cd ~/public_html
mkdir -p logs images api css js
chmod 755 logs images api css js
```

### Step 5: Test Contact Form

1. Visit: https://osakaoaks.org
2. Scroll to contact section
3. Fill out and submit form
4. Check email at jorel@osakaoaks.org
5. Check logs: `~/public_html/logs/contact-submissions.log`

### Step 6: Enable Security Features

**A. ModSecurity (Web Application Firewall)**
- Go to cPanel → Security → ModSecurity
- Enable ModSecurity
- Use default rules

**B. Hotlink Protection**
- Go to cPanel → Security → Hotlink Protection
- Enable to prevent image theft

**C. IP Blocker (Optional)**
- Go to cPanel → Security → IP Blocker
- Block malicious IPs if needed

**D. Add Security Headers to .htaccess:**
```apache
# Security Headers
<IfModule mod_headers.c>
    Header set X-Content-Type-Options "nosniff"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-XSS-Protection "1; mode=block"
    Header set Referrer-Policy "strict-origin-when-cross-origin"
    Header set Permissions-Policy "geolocation=(), microphone=(), camera=()"
</IfModule>

# Prevent directory listing
Options -Indexes

# Protect sensitive files
<FilesMatch "^(\.env|\.git|\.htaccess|\.htpasswd|wp-config\.php)">
    Order allow,deny
    Deny from all
</FilesMatch>
```

### Step 7: Configure Automated Backups

**A. Enable cPanel Backups**
1. Go to cPanel → Files → Backup Wizard
2. Set up weekly full backups
3. Store backups off-site if possible

**B. GitHub Actions Backups (Already configured)**
- Automated daily backups via CI/CD
- 30-day retention on GitHub Artifacts
- Database + files backed up before each deployment

---

## 🔐 Security Checklist

- [ ] SSL/TLS certificate enabled (HTTPS)
- [ ] ModSecurity enabled
- [ ] Secure file permissions (644 for files, 755 for directories)
- [ ] Contact form rate limiting active
- [ ] Security headers in .htaccess
- [ ] Directory listing disabled
- [ ] Email configured and tested
- [ ] Automated backups running
- [ ] Git credentials secured
- [ ] No sensitive data in repository

---

## 📊 Monitoring & Maintenance

### Check Website Status
```bash
curl -I https://osakaoaks.org
```

### View Contact Form Submissions
```bash
ssh osakuqbj@osakaoaks.org -p 21098
cat ~/public_html/logs/contact-submissions.log
```

### Check Error Logs
```bash
tail -f ~/public_html/logs/contact-errors.log
```

### Monitor Disk Usage
```bash
du -sh ~/public_html/
```

---

## 🎨 Customization

### Update Company Information

**Edit `index.html`:**
- Hero section text
- About section content
- Services descriptions
- Contact information

### Change Colors

**Edit `css/styles.css`:**
```css
:root {
    --primary-color: #2563eb;    /* Blue */
    --secondary-color: #10b981;   /* Green */
    --accent-color: #f59e0b;      /* Orange */
}
```

### Add Images

1. Add images to `images/` folder
2. Update references in HTML:
```html
<img src="images/your-image.jpg" alt="Description">
```

### Add Pages

Create new HTML files:
- `about.html` - Detailed about page
- `services.html` - Services portfolio
- `privacy.html` - Privacy policy
- `terms.html` - Terms of service

---

## 🚀 CI/CD Pipeline

### Automatic Deployment Flow

```
1. Edit files locally in Cursor/VS Code
2. Commit changes: git commit -m "Update website"
3. Push to GitHub: git push origin main
4. GitHub Actions triggers automatically
5. Security scan runs
6. Backup created (database + files)
7. New version deployed
8. Health check performed
9. Notification sent
```

### Manual Deployment Trigger

Go to: https://github.com/JorelFuji/osakaoaks-website/actions
Click "Run workflow" to manually deploy

---

## 📧 Contact Form Configuration

### Email Settings

**Default recipient:** `jorel@osakaoaks.org`

**To change:**
Edit `api/contact.php` line 70:
```php
$to = 'your-email@osakaoaks.org';
```

### Rate Limiting

**Current:** 1 submission per minute per session

**To change:**
Edit `api/contact.php` line 20:
```php
if ($current_time - $last_submission < 60) { // Change 60 to desired seconds
```

### Spam Protection

Built-in features:
- Input sanitization
- Email validation
- URL pattern detection
- Rate limiting
- Session tracking

---

## 🐛 Troubleshooting

### Contact Form Not Working

1. Check PHP mail() function:
```bash
php -r "mail('jorel@osakaoaks.org', 'Test', 'Test message');"
```

2. Check logs:
```bash
cat ~/public_html/logs/contact-errors.log
```

3. Verify email account exists in cPanel

### Website Not Loading

1. Check file permissions
2. Verify .htaccess syntax
3. Check error logs in cPanel
4. Test with: `curl -I https://osakaoaks.org`

### SSL Certificate Issues

1. Go to cPanel → SSL/TLS Status
2. Verify certificate is valid
3. Force reinstall if needed

### Deployment Failures

1. Check GitHub Actions: https://github.com/JorelFuji/osakaoaks-website/actions
2. Review error logs
3. Verify SSH keys are correct
4. Test SSH connection manually

---

## 📝 Next Steps

### Enhance the Website:

1. **Add Content**
   - Write detailed about page
   - Add service descriptions
   - Include testimonials
   - Create portfolio/case studies

2. **Improve SEO**
   - Add meta descriptions
   - Create sitemap.xml
   - Set up Google Analytics
   - Submit to Google Search Console

3. **Add Features**
   - Blog section
   - Newsletter signup
   - Live chat support
   - Social media integration

4. **Performance**
   - Optimize images
   - Enable caching
   - Minify CSS/JS
   - Use CDN

---

## 📞 Support

**Website:** https://osakaoaks.org
**Email:** jorel@osakaoaks.org
**GitHub:** https://github.com/JorelFuji/osakaoaks-website

---

## ✅ Launch Checklist

Before going live:

- [ ] All content proofread
- [ ] Contact form tested
- [ ] SSL certificate active
- [ ] Mobile responsive verified
- [ ] All links working
- [ ] Images optimized
- [ ] SEO meta tags added
- [ ] Google Analytics installed
- [ ] Backups configured
- [ ] Security measures active
- [ ] Performance tested
- [ ] Cross-browser tested

---

**Ready to deploy?** Run:

```bash
cd /Users/m1876041/Documents/Github/OsakaOaks
git add website/
git commit -m "Deploy professional website"
git push origin main
```

Then watch it auto-deploy: https://github.com/JorelFuji/osakaoaks-website/actions

🎉 **Your secure, professional website will be live!**
