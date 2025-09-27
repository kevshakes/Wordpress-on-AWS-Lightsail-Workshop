#!/usr/bin/env bash
# Helper: Launch Bitnami's HTTPS configuration tool for Let's Encrypt
# Note: bncert-tool is interactive; ensure your DuckDNS domain resolves to this instance IP.
set -euo pipefail

if [[ ! -x "/opt/bitnami/bncert-tool" ]]; then
  echo "Bitnami bncert-tool not found at /opt/bitnami/bncert-tool" >&2
  exit 1
fi

echo "Opening Bitnami HTTPS configuration tool..."
echo "Prereqs:"
echo " 1) DuckDNS subdomain points to this instance's STATIC IP"
echo " 2) Ports 80 and 443 open in Lightsail Networking"
echo " 3) Be ready to enter your domain (e.g., mysite.duckdns.org)"
sudo /opt/bitnami/bncert-tool
