#!/bin/bash

echo "🔍 OsakaOaks Deployment Verification"
echo "====================================="
echo ""

check_url() {
    local url=$1
    local name=$2
    
    echo -n "Checking $name... "
    
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url" --max-time 10)
    
    if [ "$status" = "200" ]; then
        echo "✅ Online (HTTP $status)"
        return 0
    else
        echo "⚠️  HTTP $status"
        return 1
    fi
}

echo "🌐 Testing Production Site"
check_url "https://osakaoaks.org" "osakaoaks.org"

echo ""
echo "🔧 Testing Dev Site"
check_url "https://jarrelspiller.osakaoaks.org" "jarrelspiller.osakaoaks.org"

echo ""
echo "🔐 Testing SSH Access"
echo -n "Production server... "
if ssh -o BatchMode=yes -o ConnectTimeout=5 osakaoaks-prod "exit" 2>/dev/null; then
    echo "✅ Connected"
else
    echo "❌ Cannot connect"
fi

echo ""
echo "📦 Checking Git Status on Server"
echo ""
echo "Production branch:"
ssh osakaoaks-prod "cd /home/osakuqbj/public_html && git branch && git log --oneline -1" 2>/dev/null || echo "❌ Could not check production Git status"

echo ""
echo "Dev branch:"
ssh osakaoaks-dev "cd /home/osakuqbj/jarrelspiller.osakaoaks.org && git branch && git log --oneline -1" 2>/dev/null || echo "❌ Could not check dev Git status"

echo ""
echo "====================================="
echo "Verification complete!"
