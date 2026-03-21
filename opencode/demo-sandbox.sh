#!/bin/bash
# Demonstration: What files are accessible INSIDE vs OUTSIDE the sandbox

echo "=== FILES ACCESSIBLE OUTSIDE (host) but NOT inside sandbox ==="
echo ""

echo "1. Home directory root (~):"
ls ~ | head -10
echo ""

echo "2. .bashrc (exists but NOT mounted in sandbox):"
ls -la ~/.bashrc 2>/dev/null || echo "~/.bashrc does NOT exist"
echo ""

echo "3. /etc/shadow (sensitive):"
ls -la /etc/shadow 2>/dev/null || echo "Access denied"
echo ""

echo "=== FILES THAT WOULD BE ACCESSIBLE INSIDE SANDBOX ==="
echo ""

OPENCODE_DIR="/home/xam/.opencode"
CONFIG_DIR="$HOME/.config/opencode"
DATA_DIR="$HOME/.local/share/opencode"
PROJECT_DIR=$(pwd)

echo "1. opencode binary ($OPENCODE_DIR/bin/opencode):"
ls -la "$OPENCODE_DIR/bin/opencode"
echo ""

echo "2. Config dir ($CONFIG_DIR):"
ls -la "$CONFIG_DIR"
echo ""

echo "3. Data dir ($DATA_DIR):"
ls -la "$DATA_DIR"
echo ""

echo "4. Project dir ($PROJECT_DIR):"
ls -la "$PROJECT_DIR"
echo ""

echo "=== SYSTEM DIRECTORIES (read-only in sandbox) ==="
echo ""
echo "/usr (read-only):"
ls /usr | head -5
echo ""

echo "/etc/resolv.conf (read-only):"
cat /etc/resolv.conf | head -3
echo ""

echo "=== ATTEMPTS THAT WOULD FAIL INSIDE SANDBOX ==="
echo ""
echo "1. Writing to /usr (should fail):"
touch /usr/test_write 2>&1 || echo "BLOCKED - cannot write to /usr"
echo ""

echo "2. Accessing /root (should fail):"
ls /root 2>&1 || echo "BLOCKED - /root not accessible"
echo ""

echo "3. Accessing other user's home:"
ls /home/otheruser 2>&1 || echo "BLOCKED - other homes not mounted"
