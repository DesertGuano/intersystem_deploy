#!/usr/bin/env bash
set -euo pipefail

# run-deploy.sh – wrapper script to decrypt and run the encrypted deploy.sh.enc

# 1) Ensure OpenSSL is installed
if ! command -v openssl >/dev/null 2>&1; then
  echo "🔄 Installing OpenSSL..."
  dnf install -y openssl
fi

# 2) Prompt for the decryption password
read -s -p "Enter password to decrypt deploy.sh: " PW
echo

# 3) Decrypt and execute the deploy script in one step
echo "🔐 Decrypting and running deploy.sh.enc..."
openssl enc -d -aes-256-cbc -salt \
  -in deploy.sh.enc \
  -pass pass:"$PW" | bash

# 4) Completion message
echo "✅ deploy.sh execution complete."
