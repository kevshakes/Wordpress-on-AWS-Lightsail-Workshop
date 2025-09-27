# One-Page Cheat Sheet: WP on Lightsail + DuckDNS

**Concept Map**
AWS (cloud) → Lightsail (easy VPS) → WordPress (CMS on instance) → DuckDNS (free hostname) → Optional: Let’s Encrypt (HTTPS)

**High-Level Steps**
1. Lightsail: Create instance (WordPress blueprint), attach static IP
2. SSH (browser): get admin password → login to `wp-admin`
3. DuckDNS: create subdomain → point to static IP → test HTTP
4. HTTPS: run `sudo /opt/bitnami/bncert-tool` → test HTTPS

**Ports**
- 22 (SSH), 80 (HTTP), 443 (HTTPS) → allow in Lightsail Networking

**Fallbacks**
- Re-copy admin password if lost
- Re-check DNS (DuckDNS) and IP
- Use snapshots before risky changes
