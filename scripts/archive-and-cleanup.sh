#!/bin/bash

# OsakaOaks Server Archive & Cleanup Script
# This script will:
# 1. Create a complete WordPress archive
# 2. Organize working vs non-working files
# 3. Clean up old logs and unused files

echo "🗂️  OsakaOaks Server Archive & Cleanup"
echo "======================================="
echo ""
echo "⚠️  This script will:"
echo "   1. Archive WordPress production site"
echo "   2. Organize files into working/archived directories"
echo "   3. Clean up old logs, backups, and temporary files"
echo ""
read -p "Continue? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "❌ Cancelled"
    exit 0
fi

ssh osakuqbj@osakaoaks.org -p 21098 << 'ENDSSH'

# Create archive directory structure
echo "📁 Creating organization structure..."
mkdir -p ~/archives/wordpress
mkdir -p ~/archives/old-projects
mkdir -p ~/working/production
mkdir -p ~/working/development
mkdir -p ~/cleanup-review

# Get timestamp for archive
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 STEP 1: Archive WordPress Production"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd /home/osakuqbj

# Create full WordPress backup
echo "💾 Creating WordPress archive..."
tar -czf "archives/wordpress/wordpress_full_backup_${TIMESTAMP}.tar.gz" \
    --exclude='public_html/wp-content/cache' \
    --exclude='public_html/wp-content/uploads/*.tmp' \
    public_html/

ARCHIVE_SIZE=$(du -sh "archives/wordpress/wordpress_full_backup_${TIMESTAMP}.tar.gz" | cut -f1)
echo "✅ WordPress archived: wordpress_full_backup_${TIMESTAMP}.tar.gz ($ARCHIVE_SIZE)"

# Create database info file
echo "📝 Creating database info..."
cat > "archives/wordpress/database_info_${TIMESTAMP}.txt" << 'EOF'
WordPress Database Backup Information
======================================

To backup the database, use phpMyAdmin or run:
mysqldump -u [username] -p [database_name] > wordpress_db_backup.sql

Database credentials are in: wp-config.php

Archive created: $(date)
EOF

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 STEP 2: Analyzing Directories"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create analysis report
echo "Generating analysis report..."
cat > "analysis_report_${TIMESTAMP}.txt" << 'REPORT'
OsakaOaks Server Analysis Report
=================================

WORKING DIRECTORIES (Active):
EOF

# Analyze each directory
for dir in */; do
    if [ -d "$dir" ]; then
        DIR_NAME="${dir%/}"
        LAST_MOD=$(stat -c %Y "$dir" 2>/dev/null)
        NOW=$(date +%s)
        DAYS_OLD=$(( (NOW - LAST_MOD) / 86400 ))
        SIZE=$(du -sh "$dir" 2>/dev/null | cut -f1)
        FILE_COUNT=$(find "$dir" -type f 2>/dev/null | wc -l)
        
        # Categorize
        if [ $DAYS_OLD -lt 30 ]; then
            STATUS="🟢 ACTIVE"
            echo "$DIR_NAME - $SIZE - $FILE_COUNT files - Last modified: $DAYS_OLD days ago" >> "analysis_report_${TIMESTAMP}.txt"
        elif [ $DAYS_OLD -lt 90 ]; then
            STATUS="🟡 MODERATE"
        else
            STATUS="🔴 INACTIVE"
        fi
        
        echo "$STATUS $DIR_NAME ($SIZE, $FILE_COUNT files, ${DAYS_OLD}d old)"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 STEP 3: Categorizing Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Identify working directories
echo "✅ Working directories (keeping in place):"
for dir in public_html jarrelspiller.osakaoaks.org mail etc ssl .ssh; do
    if [ -d "$dir" ]; then
        SIZE=$(du -sh "$dir" 2>/dev/null | cut -f1)
        echo "  📂 $dir ($SIZE)"
    fi
done

echo ""
echo "📦 Directories to review for archival:"
# Find old directories
find . -maxdepth 1 -type d -mtime +90 2>/dev/null | \
    grep -v "^\." | \
    grep -v "public_html" | \
    grep -v "jarrelspiller" | \
    grep -v "mail" | \
    grep -v "ssl" | \
    grep -v "etc" | \
    grep -v "archives" | \
    grep -v "working" | \
    while read old_dir; do
        DIR_NAME=$(basename "$old_dir")
        SIZE=$(du -sh "$old_dir" 2>/dev/null | cut -f1)
        MODIFIED=$(stat -c %y "$old_dir" 2>/dev/null | cut -d' ' -f1)
        echo "  🔴 $DIR_NAME ($SIZE) - Last: $MODIFIED"
    done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧹 STEP 4: Cleanup Candidates"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Find old backups
echo "📦 Old backup files (180+ days):"
find . -name "*backup*" -type f -mtime +180 2>/dev/null | while read file; do
    SIZE=$(du -sh "$file" 2>/dev/null | cut -f1)
    echo "  - $(basename $file) ($SIZE)"
done | head -10

echo ""
echo "📋 Large log files (>10MB):"
find . -name "*.log" -size +10M 2>/dev/null | while read file; do
    SIZE=$(du -sh "$file" 2>/dev/null | cut -f1)
    echo "  - $file ($SIZE)"
done | head -10

echo ""
echo "🗑️  Trash folder:"
if [ -d ".trash" ]; then
    TRASH_SIZE=$(du -sh .trash 2>/dev/null | cut -f1)
    TRASH_FILES=$(find .trash -type f 2>/dev/null | wc -l)
    echo "  Size: $TRASH_SIZE ($TRASH_FILES files)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 DISK USAGE SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

du -sh */ 2>/dev/null | sort -hr | head -15

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Analysis Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📄 Full report saved: ~/analysis_report_${TIMESTAMP}.txt"
echo ""
echo "Next steps:"
echo "1. Review the analysis report"
echo "2. WordPress backup is in: ~/archives/wordpress/"
echo "3. Use cleanup scripts to remove old files"
echo ""

ENDSSH

echo ""
echo "✅ Server analysis complete!"
echo ""
