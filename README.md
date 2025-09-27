# WordPress on AWS Lightsail with DuckDNS (Workshop Repo)

A concise, hands-on guide to deploy a **WordPress** site on **AWS Lightsail** and map it to a free **DuckDNS** subdomain. Includes helper scripts and a clean workshop flow.

> Designed for live workshops and self-paced learners. Minimal prerequisites, console-first path, and optional CLI tips.

---

## 📦 What’s in this repo
- `README.md` — step-by-step workshop guide
- `scripts/get-wp-admin-password.sh` — fetch Bitnami WP admin password
- `scripts/setup-https.sh` — helper to run Let's Encrypt via Bitnami `bncert-tool`
- `scripts/notes-lightsail-cli.md` — optional AWS CLI tips (bonus)
- `assets/cheatsheet.md` — one-page cheat sheet outline
- `LICENSE` — MIT

---

## ✅ Prerequisites (for the workshop lead/participants)
- AWS account with access to **Lightsail**
- A GitHub/Google account to sign into **DuckDNS**
- (Optional) SSH familiarity (we also use **browser-based SSH** in Lightsail)
- No custom domain needed — we use DuckDNS (e.g., `yourname.duckdns.org`)

---

## 🛠️ Steps (Console-first)
### 1) Create a Lightsail Instance
1. Sign in to AWS Console → search **Lightsail** → **Create instance**
2. Choose **Region** (nearest), **Platform**: Linux/Unix, **Blueprint**: **WordPress**
3. Pick a plan (lowest tier is fine for demo), name it (e.g., `workshop-wp`) → **Create**
4. When running, go to **Networking** → **Create static IP**, attach to the instance

### 2) Connect & get WordPress admin password
1. From instance page → **Connect using SSH** (in browser)
2. Run:
   ```bash
   sudo cat /home/bitnami/bitnami_application_password
   ```
   This outputs your WordPress admin password.
3. Open `http://<YOUR-STATIC-IP>/wp-admin`
   - **Username**: `user`
   - **Password**: *(from step 2)*
4. Complete initial WordPress setup (title, email, language)

### 3) Set up DuckDNS (free subdomain)
1. Go to https://www.duckdns.org and sign in (GitHub/Google)
2. Create a subdomain, e.g., `myawsdemo.duckdns.org`
3. Add your **Lightsail static IP** to that subdomain
4. Test: visit `http://myawsdemo.duckdns.org` → should show your WordPress site

### 4) (Optional but recommended) Enable HTTPS with Let’s Encrypt
1. In Lightsail **SSH** session, run:
   ```bash
   sudo /opt/bitnami/bncert-tool
   ```
2. When prompted, enter your DuckDNS domain (e.g., `myawsdemo.duckdns.org`), agree to redirects/renewals
3. After success, access your site via `https://`

> **Notes**
> - `bncert-tool` is interactive; the script in `scripts/setup-https.sh` simply checks prerequisites and launches it.
> - Let’s Encrypt requires your domain to resolve to the instance’s IP and ports **80/443** to be open (Lightsail firewall → **Networking**).

### 5) Verify & Wrap-up
- Visit `https://myawsdemo.duckdns.org`
- Log into `wp-admin` and install a theme/plugin to show success
- (Optional) Create a snapshot in Lightsail for backup

---

## 🔧 Troubleshooting
- **DuckDNS not resolving?** Wait ~1–5 minutes or re-check that you used the **static IP**.
- **SSL/HTTPS fails?** Ensure ports 80/443 are open in Lightsail **Networking** and the domain resolves to your IP.
- **Admin password unknown?** Use `sudo cat /home/bitnami/bitnami_application_password` again via SSH.
- **White page/500 error?** Disable the last plugin via `wp-cli` (advanced) or roll back with a snapshot.

---

## 🧪 Bonus: CLI Notes (Optional)
See `scripts/notes-lightsail-cli.md` for tips to perform parts of the workflow using the AWS CLI (e.g., listing instances, static IPs).

---

## 🚀 Presenting this in a Workshop
- Start with the 2-minute primer: **AWS → Lightsail → WordPress → DuckDNS** (see `assets/cheatsheet.md`).
- Then follow the steps **live**. Keep one instance pre-provisioned as a fallback.
- End with HTTPS + a quick theme install to celebrate the win 🎉

---

## 📝 License
MIT — see `LICENSE`.
