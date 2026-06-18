#!/bin/bash

echo "🔐 OsakaOaks SSH Setup Script"
echo "================================"
echo ""

SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"

echo "📋 Checking SSH directory..."
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    echo "✅ Created $SSH_DIR"
else
    echo "✅ $SSH_DIR exists"
fi

echo ""
echo "🔑 Checking for SSH keys..."

KEYS_FOUND=0

if [ -f "$SSH_DIR/rsa_prod_deploy" ]; then
    echo "✅ rsa_prod_deploy found"
    chmod 600 "$SSH_DIR/rsa_prod_deploy"
    KEYS_FOUND=$((KEYS_FOUND + 1))
else
    echo "❌ rsa_prod_deploy not found"
    echo "   Download from: cPanel → Manage Shell → SSH Keys → Private Keys → rsa_prod_deploy"
fi

if [ -f "$SSH_DIR/rsa_dev_deploy" ]; then
    echo "✅ rsa_dev_deploy found"
    chmod 600 "$SSH_DIR/rsa_dev_deploy"
    KEYS_FOUND=$((KEYS_FOUND + 1))
else
    echo "❌ rsa_dev_deploy not found"
    echo "   Download from: cPanel → Manage Shell → SSH Keys → Private Keys → rsa_dev_deploy"
fi

echo ""
echo "📝 Checking SSH config..."

if [ ! -f "$CONFIG_FILE" ]; then
    touch "$CONFIG_FILE"
    chmod 600 "$CONFIG_FILE"
    echo "✅ Created $CONFIG_FILE"
fi

if grep -q "osakaoaks-prod" "$CONFIG_FILE"; then
    echo "✅ SSH config already contains OsakaOaks entries"
else
    echo "Adding SSH config entries..."
    cat >> "$CONFIG_FILE" << 'EOF'

# OsakaOaks Server Configuration
Host osakaoaks-prod
    HostName osakaoaks.org
    User osakuqbj
    Port 21098
    IdentityFile ~/.ssh/rsa_prod_deploy
    ServerAliveInterval 60
    ServerAliveCountMax 3

Host osakaoaks-dev
    HostName osakaoaks.org
    User osakuqbj
    Port 21098
    IdentityFile ~/.ssh/rsa_dev_deploy
    ServerAliveInterval 60
    ServerAliveCountMax 3
EOF
    echo "✅ Added SSH config"
fi

echo ""
echo "🧪 Testing SSH connection..."

if [ $KEYS_FOUND -gt 0 ]; then
    echo "Attempting to connect to osakaoaks-prod..."
    if ssh -o BatchMode=yes -o ConnectTimeout=5 osakaoaks-prod "echo '✅ SSH connection successful!'" 2>/dev/null; then
        echo "✅ Production server connection works!"
    else
        echo "⚠️  Could not connect automatically"
        echo "   Try manually: ssh osakaoaks-prod"
        echo "   You may need to accept the host key on first connection"
    fi
else
    echo "⚠️  Cannot test connection - SSH keys not found"
fi

echo ""
echo "================================"
echo "Setup Summary:"
echo "  - SSH keys found: $KEYS_FOUND/2"
echo "  - SSH config: ✅"
echo ""
echo "Next steps:"
if [ $KEYS_FOUND -lt 2 ]; then
    echo "  1. Download missing SSH keys from cPanel"
    echo "  2. Move them to ~/.ssh/"
    echo "  3. Run this script again"
else
    echo "  1. Test connection: ssh osakaoaks-prod"
    echo "  2. Follow SETUP-STEPS.md for GitHub setup"
    echo "  3. Connect Cursor IDE via Remote SSH"
fi
