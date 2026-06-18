#!/bin/bash

echo "🔍 OsakaOaks Server Activity Analysis"
echo "======================================"
echo ""

ssh osakuqbj@osakaoaks.org -p 21098 << 'ENDSSH'

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "📊 Analyzing domains and folders..."
echo ""

# Get current date for comparison
NOW=$(date +%s)
THIRTY_DAYS_AGO=$((NOW - 30*24*60*60))
NINETY_DAYS_AGO=$((NOW - 90*24*60*60))

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🌐 DOMAINS & MAIN DIRECTORIES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check main directories
for dir in public_html jarrelspiller.osakaoaks.org mail home; do
    if [ -d "/home/osakuqbj/$dir" ]; then
        LAST_MOD=$(stat -c %Y "/home/osakuqbj/$dir" 2>/dev/null)
        MOD_DATE=$(stat -c %y "/home/osakuqbj/$dir" 2>/dev/null | cut -d'.' -f1)
        SIZE=$(du -sh "/home/osakuqbj/$dir" 2>/dev/null | cut -f1)
        FILE_COUNT=$(find "/home/osakuqbj/$dir" -type f 2>/dev/null | wc -l)
        
        # Determine activity status
        if [ "$LAST_MOD" -gt "$THIRTY_DAYS_AGO" ]; then
            STATUS="${GREEN}🟢 ACTIVE (Modified within 30 days)${NC}"
        elif [ "$LAST_MOD" -gt "$NINETY_DAYS_AGO" ]; then
            STATUS="${YELLOW}🟡 MODERATE (Modified within 90 days)${NC}"
        else
            STATUS="${RED}🔴 INACTIVE (Modified 90+ days ago)${NC}"
        fi
        
        echo -e "📂 $dir"
        echo -e "   Status: $STATUS"
        echo "   Last Modified: $MOD_DATE"
        echo "   Size: $SIZE"
        echo "   Files: $FILE_COUNT"
        
        # Check if it's a domain
        case "$dir" in
            "public_html")
                echo "   🌐 Domain: osakaoaks.org (PRODUCTION)"
                # Check for recent file changes
                RECENT=$(find "/home/osakuqbj/$dir" -type f -mtime -7 2>/dev/null | wc -l)
                echo "   📝 Files modified in last 7 days: $RECENT"
                ;;
            "jarrelspiller.osakaoaks.org")
                echo "   🌐 Domain: jarrelspiller.osakaoaks.org (DEV)"
                RECENT=$(find "/home/osakuqbj/$dir" -type f -mtime -7 2>/dev/null | wc -l)
                echo "   📝 Files modified in last 7 days: $RECENT"
                ;;
        esac
        echo ""
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 ALL DIRECTORIES BY LAST MODIFIED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd /home/osakuqbj
ls -lat --time-style=long-iso | grep '^d' | awk '{print $6" "$7" "$8}' | head -20

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  POTENTIALLY UNUSED DIRECTORIES (90+ days old)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

find /home/osakuqbj -maxdepth 1 -type d -mtime +90 -exec ls -ld --time-style=long-iso {} \; 2>/dev/null | \
    grep -v "^\." | \
    awk '{print $6" "$7" - "$9}' | \
    sed 's|/home/osakuqbj/||'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📈 RECENT ACTIVITY (Last 7 days)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Production (public_html):"
PROD_RECENT=$(find /home/osakuqbj/public_html -type f -mtime -7 2>/dev/null | wc -l)
echo "  Files modified: $PROD_RECENT"

echo ""
echo "Dev (jarrelspiller.osakaoaks.org):"
DEV_RECENT=$(find /home/osakuqbj/jarrelspiller.osakaoaks.org -type f -mtime -7 2>/dev/null | wc -l)
echo "  Files modified: $DEV_RECENT"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💾 DISK USAGE BY DIRECTORY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

du -sh /home/osakuqbj/*/ 2>/dev/null | sort -hr | head -15

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🗑️  RECOMMENDATIONS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for old backups
OLD_BACKUPS=$(find /home/osakuqbj -name "*backup*" -type f -mtime +180 2>/dev/null | wc -l)
if [ "$OLD_BACKUPS" -gt 0 ]; then
    echo "⚠️  Found $OLD_BACKUPS backup files older than 180 days"
    echo "   Consider cleaning: find /home/osakuqbj -name '*backup*' -mtime +180"
fi

# Check for large log files
LARGE_LOGS=$(find /home/osakuqbj -name "*.log" -size +10M 2>/dev/null | wc -l)
if [ "$LARGE_LOGS" -gt 0 ]; then
    echo "⚠️  Found $LARGE_LOGS log files larger than 10MB"
    echo "   Consider cleaning: find /home/osakuqbj -name '*.log' -size +10M"
fi

# Check trash
TRASH_SIZE=$(du -sh /home/osakuqbj/.trash 2>/dev/null | cut -f1)
echo "🗑️  Trash folder size: $TRASH_SIZE"

# Check for unused node modules
NODE_MODULES=$(find /home/osakuqbj -name "node_modules" -type d 2>/dev/null | wc -l)
if [ "$NODE_MODULES" -gt 0 ]; then
    echo "📦 Found $NODE_MODULES node_modules directories"
fi

echo ""
echo "✅ Analysis complete!"
echo ""

ENDSSH
