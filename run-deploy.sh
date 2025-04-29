#!/usr/bin/env bash
set -euo pipefail

# run-deploy.sh – wrapper to fetch, decrypt, run, and cleanup deployment

# 1) Ensure git and OpenSSL are installed
if ! command -v git >/dev/null 2>&1; then
  echo "🔄 Installing git..."
  dnf install -y git
fi
if ! command -v openssl >/dev/null 2>&1; then
  echo "🔄 Installing OpenSSL..."
  dnf install -y openssl
fi

# 2) Clone or update repository into /root/intersystem_deploy
REPO_URL="https://github.com/DesertGuano/intersystem_deploy.git"
DEST_DIR="/root/intersystem_deploy"
if [[ ! -d "$DEST_DIR" ]]; then
  echo "🔄 Cloning deployment repository to $DEST_DIR"
  git clone "$REPO_URL" "$DEST_DIR"
else
  echo "🔄 Updating deployment repository in $DEST_DIR"
  cd "$DEST_DIR"
  git pull
fi
cd "$DEST_DIR"

# 3) Prompt for decryption password
read -s -p "Enter password to decrypt deploy.sh: " PW
echo

# 4) Decrypt and execute the deploy script
echo "🔐 Decrypting and running deploy.sh.enc..."
openssl enc -d -aes-256-cbc -salt \
  -in deploy.sh.enc \
  -pass pass:"$PW" | bash

echo "✅ deploy.sh execution complete."

# 5) Cleanup: remove deployment directory
echo "🔄 Cleaning up deployment files..."
cd /root
rm -rf "$DEST_DIR"
echo "✅ Cleanup complete."
