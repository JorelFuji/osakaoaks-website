#!/bin/bash

# Osaka Oaks React Website Deployment Script
# Deploys the React build to osakaoaks.org

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Server details
SSH_HOST="osakaoaks.org"
SSH_PORT="21098"
SSH_USER="osakuqbj"
REMOTE_PATH="/home/osakuqbj/public_html"
LOCAL_BUILD_PATH="$PROJECT_ROOT/osaka-oaks-react/dist"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Osaka Oaks React Website Deployment${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if build exists
if [ ! -d "$LOCAL_BUILD_PATH" ]; then
    echo -e "${RED}✗ Error: Build directory not found!${NC}"
    echo -e "${YELLOW}  Run 'cd osaka-oaks-react && npm run build' first${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Build directory found${NC}"
echo ""

# Create backup of current site
echo -e "${YELLOW}📦 Creating backup of current site...${NC}"
BACKUP_NAME="backup-$(date +%Y%m%d_%H%M%S).tar.gz"
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST "cd $REMOTE_PATH && tar -czf ~/website-backups/$BACKUP_NAME --exclude='*.tar.gz' --exclude='.git' --exclude='node_modules' --exclude='archived-wordpress' ."
echo -e "${GREEN}✓ Backup created: ~/website-backups/$BACKUP_NAME${NC}"
echo ""

# Clear remote directory (keep important files)
echo -e "${YELLOW}🗑️  Clearing remote directory...${NC}"
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST << 'ENDSSH'
cd ~/public_html
# Remove old website files but keep important directories
find . -maxdepth 1 -type f ! -name '.htaccess' ! -name '.cpanel.yml' ! -name '.ftpquota' -delete
rm -rf css js images videos api
ENDSSH
echo -e "${GREEN}✓ Directory cleared${NC}"
echo ""

# Deploy new React build
echo -e "${YELLOW}📤 Deploying React build...${NC}"
rsync -avz --progress -e "ssh -p $SSH_PORT" \
    --exclude='*.map' \
    $LOCAL_BUILD_PATH/ $SSH_USER@$SSH_HOST:$REMOTE_PATH/

echo -e "${GREEN}✓ Files deployed${NC}"
echo ""

# Set permissions
echo -e "${YELLOW}🔐 Setting file permissions...${NC}"
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST << 'ENDSSH'
cd ~/public_html
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
chmod 644 .htaccess 2>/dev/null || true
ENDSSH
echo -e "${GREEN}✓ Permissions set${NC}"
echo ""

# Verify deployment
echo -e "${YELLOW}✅ Verifying deployment...${NC}"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://osakaoaks.org)
if [ "$HTTP_CODE" = "200" ]; then
    echo -e "${GREEN}✓ Website is live and responding (HTTP $HTTP_CODE)${NC}"
else
    echo -e "${YELLOW}⚠ Website returned HTTP $HTTP_CODE${NC}"
fi
echo ""

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ DEPLOYMENT COMPLETE!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}🎉 React website deployed successfully!${NC}"
echo ""
echo -e "${BLUE}🌐 Visit: ${GREEN}https://osakaoaks.org${NC}"
echo ""
echo -e "${YELLOW}📦 Backup location: ~/website-backups/$BACKUP_NAME${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
