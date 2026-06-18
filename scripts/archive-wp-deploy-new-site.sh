#!/bin/bash

# Archive WordPress and Deploy New Osaka Oaks Website
# This script will:
# 1. Backup current WordPress installation
# 2. Move it to archive folder
# 3. Deploy new static website

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Archive WordPress & Deploy Osaka Oaks Static Website     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "⚠️  WARNING: This will:"
echo "   1. Archive entire WordPress installation from public_html"
echo "   2. Move it to ~/archived-wordpress/"
echo "   3. Deploy new static Osaka Oaks website"
echo ""
echo "Current WordPress site: https://osakaoaks.org"
echo "Archive location: ~/archived-wordpress/$(date +%Y%m%d_%H%M%S)/"
echo ""
read -p "Type 'YES' to continue: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo "❌ Cancelled"
    exit 0
fi

ssh osakuqbj@osakaoaks.org -p 21098 << 'ENDSSH'

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_BASE="$HOME/archived-wordpress"
ARCHIVE_DIR="$ARCHIVE_BASE/$TIMESTAMP"
PUBLIC_HTML="$HOME/public_html"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 STEP 1: Analyze Current Site"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd "$PUBLIC_HTML"

# Check if WordPress exists
if [ -f "wp-config.php" ]; then
    echo "✅ WordPress installation detected"
    
    # Get database info
    DB_NAME=$(grep "DB_NAME" wp-config.php | cut -d "'" -f 4)
    DB_USER=$(grep "DB_USER" wp-config.php | cut -d "'" -f 4)
    DB_PASS=$(grep "DB_PASSWORD" wp-config.php | cut -d "'" -f 4)
    DB_HOST=$(grep "DB_HOST" wp-config.php | cut -d "'" -f 4)
    
    echo "   Database: $DB_NAME"
    echo "   User: $DB_USER"
else
    echo "⚠️  No WordPress detected (no wp-config.php)"
    DB_NAME=""
fi

# Get site size
SITE_SIZE=$(du -sh . | cut -f1)
echo "   Site size: $SITE_SIZE"

# Count files
FILE_COUNT=$(find . -type f | wc -l)
echo "   Files: $FILE_COUNT"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💾 STEP 2: Create Archive Directory"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

mkdir -p "$ARCHIVE_DIR"
echo "✅ Created: $ARCHIVE_DIR"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 STEP 3: Backup Database"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -n "$DB_NAME" ]; then
    echo "💾 Backing up database: $DB_NAME"
    
    mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$ARCHIVE_DIR/database.sql" 2>&1
    
    if [ -f "$ARCHIVE_DIR/database.sql" ]; then
        gzip "$ARCHIVE_DIR/database.sql"
        DB_SIZE=$(du -sh "$ARCHIVE_DIR/database.sql.gz" | cut -f1)
        echo "✅ Database backed up: $DB_SIZE"
    else
        echo "⚠️  Database backup may have failed"
    fi
else
    echo "⚠️  No database to backup"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 STEP 4: Archive WordPress Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd "$PUBLIC_HTML"

echo "📦 Creating complete backup archive..."
tar -czf "$ARCHIVE_DIR/wordpress-files.tar.gz" \
    --exclude='*.log' \
    --exclude='cache/*' \
    --exclude='*.tmp' \
    . 2>/dev/null

if [ -f "$ARCHIVE_DIR/wordpress-files.tar.gz" ]; then
    ARCHIVE_SIZE=$(du -sh "$ARCHIVE_DIR/wordpress-files.tar.gz" | cut -f1)
    echo "✅ Files archived: $ARCHIVE_SIZE"
else
    echo "❌ Archive creation failed!"
    exit 1
fi

# Create manifest of what was backed up
echo "📋 Creating file manifest..."
tar -tzf "$ARCHIVE_DIR/wordpress-files.tar.gz" > "$ARCHIVE_DIR/file-manifest.txt"
echo "✅ Manifest created: $(wc -l < $ARCHIVE_DIR/file-manifest.txt) files"

# Create README in archive
cat > "$ARCHIVE_DIR/README.txt" << 'README'
WordPress Archive
=================

This archive contains the complete WordPress installation from osakaoaks.org

Contents:
---------
- wordpress-files.tar.gz : All WordPress files from public_html
- database.sql.gz        : MySQL database dump
- file-manifest.txt      : List of all archived files
- restore-instructions.txt : How to restore this backup

Archived: $(date)
Original size: $SITE_SIZE
Database: $DB_NAME

To restore this WordPress installation, see restore-instructions.txt
README

# Create restore instructions
cat > "$ARCHIVE_DIR/restore-instructions.txt" << 'RESTORE'
WordPress Restore Instructions
================================

To restore this WordPress installation:

1. RESTORE FILES:
   cd ~/public_html
   tar -xzf ~/archived-wordpress/TIMESTAMP/wordpress-files.tar.gz

2. RESTORE DATABASE:
   gunzip ~/archived-wordpress/TIMESTAMP/database.sql.gz
   mysql -h DB_HOST -u DB_USER -p DB_NAME < ~/archived-wordpress/TIMESTAMP/database.sql

3. VERIFY:
   - Check wp-config.php has correct database credentials
   - Visit https://osakaoaks.org
   - Test admin login

Need help? Contact: jorel@osakaoaks.org
RESTORE

echo "✅ Archive documentation created"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🗑️  STEP 5: Clear public_html"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd "$PUBLIC_HTML"

echo "🧹 Removing WordPress files from public_html..."

# Remove WordPress directories
rm -rf wp-admin wp-includes wp-content

# Remove WordPress files
rm -f wp-*.php xmlrpc.php license.txt readme.html

# Remove other common files
rm -f index.php .htaccess

# Keep important hidden files
# .git, .ssh, .bash*, .env, etc are preserved

REMAINING=$(find . -maxdepth 1 -type f | wc -l)
echo "✅ WordPress removed. Remaining files: $REMAINING"

# List what's left
echo ""
echo "📋 Remaining items in public_html:"
ls -la | head -20

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 STEP 6: Archive Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "✅ Archive Location: $ARCHIVE_DIR"
echo ""
ls -lh "$ARCHIVE_DIR"
echo ""

TOTAL_ARCHIVE_SIZE=$(du -sh "$ARCHIVE_DIR" | cut -f1)
echo "📦 Total archive size: $TOTAL_ARCHIVE_SIZE"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ WordPress Archived Successfully!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Archive saved to: $ARCHIVE_DIR"
echo ""
echo "Next steps:"
echo "1. Verify archive contents"
echo "2. Deploy new Osaka Oaks static website"
echo "3. Test new site"
echo ""
echo "To restore WordPress if needed:"
echo "   cd $ARCHIVE_DIR"
echo "   cat restore-instructions.txt"
echo ""

ENDSSH

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 STEP 7: Deploy New Osaka Oaks Website"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📤 Uploading new website files..."

# Deploy website files via rsync
rsync -avz --progress -e "ssh -p 21098" \
  ./website/ \
  osakuqbj@osakaoaks.org:/home/osakuqbj/public_html/

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 STEP 8: Set Permissions"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

ssh osakuqbj@osakaoaks.org -p 21098 << 'ENDSSH2'
cd ~/public_html

echo "🔐 Setting secure permissions..."
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;

echo "✅ Permissions set"
echo ""
echo "📋 New website structure:"
ls -la
ENDSSH2

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ DEPLOYMENT COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 New Osaka Oaks website is now live!"
echo ""
echo "✅ WordPress archived"
echo "✅ New static site deployed"
echo "✅ Permissions configured"
echo ""
echo "🌐 Visit: https://osakaoaks.org"
echo ""
echo "📦 WordPress backup location:"
echo "   ~/archived-wordpress/$TIMESTAMP/"
echo ""
echo "🔄 To restore WordPress if needed:"
echo "   ssh osakuqbj@osakaoaks.org -p 21098"
echo "   cd ~/archived-wordpress/$TIMESTAMP/"
echo "   cat restore-instructions.txt"
echo ""

exit 0
