# Osaka Oaks LLC - React Website

Modern, professional React + Vite + Tailwind CSS website for Osaka Oaks LLC - A Service-Disabled Veteran-Owned (SDVOSB) cybersecurity and defense consulting firm.

## 🚀 Features

- ⚛️ **React 18** - Modern React with hooks
- ⚡ **Vite** - Lightning fast build tool
- 🎨 **Tailwind CSS** - Utility-first CSS framework
- 🎯 **shadcn/ui** - High-quality, accessible components
- 🌐 **Bilingual** - English/Japanese language switcher
- 📱 **Responsive** - Mobile-first design
- ♿ **Accessible** - WCAG compliant
- 🔐 **Secure** - Government-contract ready

## 📦 Installation

```bash
npm install
```

## 🛠️ Development

```bash
npm run dev
```

Visit http://localhost:3000

## 🏗️ Build

```bash
npm run build
```

Output will be in `dist/` directory.

## 📤 Deploy to Production

### Manual Deploy

```bash
# Build the project
npm run build

# Deploy dist/ folder to server
rsync -avz -e "ssh -p 21098" dist/ osakuqbj@osakaoaks.org:~/public_html/
```

### Using Deployment Script

```bash
cd ..
./scripts/deploy-react-site.sh
```

## 📁 Project Structure

```
osaka-oaks-react/
├── src/
│   ├── components/
│   │   ├── TopBar.jsx
│   │   ├── Navigation.jsx
│   │   ├── Hero.jsx
│   │   ├── OakTree.jsx
│   │   ├── TrustBadges.jsx
│   │   ├── Services.jsx
│   │   ├── CEOSection.jsx
│   │   ├── Capabilities.jsx
│   │   ├── JapaneseServices.jsx
│   │   └── Footer.jsx
│   ├── lib/
│   │   └── utils.js
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css
├── public/
│   ├── images/
│   └── videos/
├── index.html
├── package.json
├── vite.config.js
├── tailwind.config.js
└── postcss.config.js
```

## 🎨 Customization

### Colors

Edit `tailwind.config.js` to change colors:

- **Navy:** #0A1628 (primary background)
- **Gold:** #C9A84C (accent color)
- **Cream:** #F6F4EC (light sections)
- **Green:** #2E5D45 (success/military)

### Content

All content is in component files in `src/components/`. Edit directly to update text, links, and information.

### Images & Videos

Place media files in `public/images/` and `public/videos/` directories. Reference them in components as `/images/filename.jpg`.

## 📊 Company Information

- **Company:** Osaka Oaks LLC
- **UEI:** MUGPMK51DFB4
- **CAGE Code:** 11WZ2
- **SAM.gov:** Active — Expires Apr 2, 2027
- **Phone:** (832) 847-5186
- **Email:** jarrel.spiller@osakaoaks.org

## 🔐 Security

- HTTPS enforced (handled by server)
- No sensitive data in client code
- Secure headers configured in .htaccess
- CSP policies enabled

## 📝 License

Private - All rights reserved © 2026 Osaka Oaks LLC

## 🆘 Support

**Website:** https://osakaoaks.org  
**Email:** jarrel.spiller@osakaoaks.org  
**Phone:** (832) 847-5186
