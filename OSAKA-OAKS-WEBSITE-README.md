# Osaka Oaks LLC - Professional Website

## 🎯 Overview

Professional, government-contract ready website for Osaka Oaks LLC - A Service-Disabled Veteran-Owned (SDVOSB) cybersecurity and defense consulting firm.

---

## ✨ Features

### **Content**
- ✅ Bilingual (English / Japanese) language switcher
- ✅ Hero section with company branding
- ✅ Trust badges (Marine Corps Veteran, Security Cleared, SAM.gov, SDVOSB, Bilingual)
- ✅ Services showcase (4 core services)
- ✅ CEO biography with credentials
- ✅ Complete capabilities statement (government-contract format)
- ✅ Japanese services section
- ✅ Professional footer with contact information

### **Design**
- ✅ Modern, professional dark theme (#0A1628 navy blue)
- ✅ Gold accent color (#C9A84C) for SDVOSB branding
- ✅ Source Serif 4 + Noto Sans JP font pairing
- ✅ Oak tree silhouette watermark in hero
- ✅ Fully responsive (desktop, tablet, mobile)
- ✅ Smooth scrolling navigation
- ✅ Hover effects and transitions

### **Technical**
- ✅ Static HTML/CSS/JavaScript (no backend required)
- ✅ Fast loading performance
- ✅ SEO optimized
- ✅ Security headers (.htaccess)
- ✅ HTTPS enforcement
- ✅ Cross-browser compatible

---

## 📁 File Structure

```
website/
├── index.html           # Main HTML file
├── css/
│   └── styles.css       # All styling
├── js/
│   └── main.js          # Language switcher & navigation
└── .htaccess            # Security & HTTPS configuration
```

---

## 🚀 Deploy Instructions

### **Option 1: Automated - Archive WordPress & Deploy (Recommended)**

```bash
cd /Users/m1876041/Documents/Github/OsakaOaks
./scripts/archive-wp-deploy-new-site.sh
```

This script will:
1. Backup WordPress database
2. Archive all WordPress files to `~/archived-wordpress/TIMESTAMP/`
3. Clear public_html
4. Deploy new Osaka Oaks website
5. Set secure permissions

### **Option 2: Manual Deployment via Git**

```bash
# 1. Commit new website
cd /Users/m1876041/Documents/Github/OsakaOaks
git add website/
git commit -m "Deploy Osaka Oaks professional website"
git push origin main

# 2. SSH to server
ssh osakuqbj@osakaoaks.org -p 21098

# 3. Pull latest changes
cd ~/public_html
git fetch origin main
git reset --hard origin/main
cp -r website/* .

# 4. Set permissions
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
```

### **Option 3: Manual Upload via cPanel**

1. Go to cPanel → File Manager
2. Navigate to `/home/osakuqbj/public_html/`
3. Delete existing WordPress files (or archive first)
4. Upload all files from `website/` folder
5. Done!

---

## 🎨 Customization Guide

### **Update Company Information**

Edit `index.html`:

```html
<!-- Contact Information -->
Line 20: (832) 847-5186
Line 23: jarrel.spiller@osakaoaks.org

<!-- Hero Title -->
Line 108-112: Main headline text

<!-- Services -->
Lines 170-221: Service cards (title, description, tag)

<!-- CEO Bio -->
Lines 234-244: CEO information

<!-- Footer -->
Lines 377-396: Footer contact and links
```

### **Change Colors**

Edit `css/styles.css`:

```css
/* Primary Colors */
Background: #0A1628 (Navy Blue)
Accent: #C9A84C (Gold)
Light BG: #F6F4EC (Cream)
Success: #2E5D45 (Green)
```

Replace these color codes throughout the CSS file.

### **Update Capabilities Statement**

Edit the capabilities section in `index.html` (lines 265-355):
- Company details
- UEI / CAGE codes
- SAM.gov status
- NAICS codes
- Core competencies
- Differentiators

---

## 🌐 Language Switcher

The website supports English and Japanese:

**How it works:**
- Click language tabs in top bar (EN / 日本語)
- JavaScript toggles content visibility
- Hero descriptions change based on selected language

**To add more translatable content:**

```html
<!-- English version -->
<p class="content-en">English text here</p>

<!-- Japanese version (hidden by default) -->
<p class="content-jp" style="display:none">日本語のテキスト</p>
```

Then update `js/main.js` to toggle visibility.

---

## 📱 Responsive Breakpoints

```css
Desktop:  > 1100px (4-column services grid)
Tablet:   768px - 1100px (2-column grid)
Mobile:   < 768px (1-column, hamburger menu)
Small:    < 480px (stacked layout)
```

---

## 🔐 Security Features

### **HTTPS Enforcement**
```apache
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

### **Security Headers**
- X-Content-Type-Options: nosniff
- X-Frame-Options: SAMEORIGIN
- X-XSS-Protection: 1; mode=block
- Content-Security-Policy
- Referrer-Policy

### **File Protection**
- Directory listing disabled
- Hidden files blocked (.git, .env, etc.)
- WordPress files protected
- PHP execution disabled in uploads/images

---

## 📊 Company Information

| Field | Value |
|-------|-------|
| **Company** | Osaka Oaks LLC |
| **UEI** | MUGPMK51DFB4 |
| **CAGE Code** | 11WZ2 |
| **SAM.gov Status** | Active — Expires Apr 2, 2027 |
| **State** | Texas, United States |
| **Address** | 6212 Belgrave Dr, Austin, Texas 78747 |
| **Phone** | (832) 847-5186 |
| **Email** | jarrel.spiller@osakaoaks.org |

**NAICS Codes:**
- 541512 (Computer Systems Design Services)
- 541519 (Other Computer Related Services)
- 541611 (Administrative Management Consulting)
- 541690 (Other Scientific and Technical Consulting)
- 561621 (Security Systems Services)

**Status:**
- ✅ Service-Disabled Veteran-Owned (SDVOSB)
- ✅ SAM.gov Active
- ✅ Security Clearance
- ✅ Bilingual English/Japanese

---

## 🧪 Testing Checklist

After deployment:

- [ ] Website loads at https://osakaoaks.org
- [ ] HTTPS enforced (no HTTP access)
- [ ] Language switcher works (EN ↔ JP)
- [ ] All navigation links work
- [ ] Smooth scrolling functional
- [ ] Mobile menu works on small screens
- [ ] All sections display correctly
- [ ] Footer links functional
- [ ] Security headers present (check with securityheaders.com)
- [ ] Page loads fast (< 2 seconds)
- [ ] Responsive on mobile devices

---

## 📞 Support

**Website:** https://osakaoaks.org  
**Email:** jarrel.spiller@osakaoaks.org  
**Phone:** (832) 847-5186

---

## 📝 Notes

### **Font Loading**
Fonts loaded from Google Fonts:
- Source Serif 4 (English headings)
- Noto Sans JP (Japanese text)

### **No Backend Required**
This is a static website with no server-side processing:
- ✅ No PHP needed
- ✅ No database needed
- ✅ No contact form backend (add FormSubmit.co if needed)
- ✅ Can host on any web server

### **Adding Contact Form**
To add a functional contact form, use FormSubmit.co:

```html
<form action="https://formsubmit.co/jarrel.spiller@osakaoaks.org" method="POST">
    <input type="hidden" name="_subject" value="New inquiry from OsakaOaks.org">
    <input type="hidden" name="_captcha" value="false">
    <input type="text" name="name" required>
    <input type="email" name="email" required>
    <textarea name="message" required></textarea>
    <button type="submit">Send</button>
</form>
```

---

## 🎉 Deployment Complete!

Your professional Osaka Oaks website is ready to replace the WordPress installation.

**Next Steps:**
1. Run the deployment script
2. Test the website
3. Update DNS if needed
4. Enable SSL certificate in cPanel
5. Monitor performance

**Ready to go live!** 🚀
