#!/usr/bin/env bash
# Helper: Fetch WordPress (Bitnami) admin password on a Lightsail instance
# Usage: run inside the instance (browser SSH): ./get-wp-admin-password.sh
set -euo pipefail

PASS_FILE="/home/bitnami/bitnami_application_password"

if [[ -f "$PASS_FILE" ]]; then
  echo "WordPress admin username: user"
  echo -n "Password: "
  sudo cat "$PASS_FILE"
  echo
else
  echo "Password file not found at $PASS_FILE" >&2
  exit 1
fi
