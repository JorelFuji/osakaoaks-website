#!/bin/bash

echo "🔧 Setting up Git on osakaoaks.org server"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "📋 Checking production directory (public_html)..."
ssh osakuqbj@osakaoaks.org -p 21098 << 'ENDSSH'
cd ~/public_html

# Check if .git exists
if [ -d .git ]; then
    echo "✅ Git already initialized in public_html"
    git remote -v
else
    echo "🔨 Initializing Git in public_html..."
    git init
    echo "✅ Git initialized"
fi

# Check/set remote
if git remote | grep -q origin; then
    echo "📍 Remote origin already exists:"
    git remote get-url origin
else
    echo "🔗 Adding GitHub remote..."
    git remote add origin https://github.com/JorelFuji/osakaoaks-website.git
    echo "✅ Remote added"
fi

# Check current branch
current_branch=$(git branch --show-current)
if [ -z "$current_branch" ]; then
    echo "🌿 No branch yet, will create main branch"
else
    echo "📌 Current branch: $current_branch"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
ENDSSH

echo "📋 Checking dev directory (jarrelspiller.osakaoaks.org)..."
ssh osakuqbj@osakaoaks.org -p 21098 << 'ENDSSH'
cd ~/jarrelspiller.osakaoaks.org

# Check if directory exists
if [ ! -d . ]; then
    echo "❌ Directory does not exist!"
    exit 1
fi

# Check if .git exists
if [ -d .git ]; then
    echo "✅ Git already initialized in jarrelspiller.osakaoaks.org"
    git remote -v
else
    echo "🔨 Initializing Git in jarrelspiller.osakaoaks.org..."
    git init
    echo "✅ Git initialized"
fi

# Check/set remote
if git remote | grep -q origin; then
    echo "📍 Remote origin already exists:"
    git remote get-url origin
else
    echo "🔗 Adding GitHub remote..."
    git remote add origin https://github.com/JorelFuji/osakaoaks-website.git
    echo "✅ Remote added"
fi

# Check current branch
current_branch=$(git branch --show-current)
if [ -z "$current_branch" ]; then
    echo "🌿 No branch yet, will create dev branch"
else
    echo "📌 Current branch: $current_branch"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ENDSSH

echo ""
echo "✅ Server Git setup complete!"
echo ""
echo "Next steps:"
echo "  1. Deploy .cpanel.yml files to both directories"
echo "  2. Test GitHub Actions deployment"
