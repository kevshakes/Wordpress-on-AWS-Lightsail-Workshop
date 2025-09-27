# 🛠️ Hands-On Workshop: Deploying WordPress on AWS Lightsail with DuckDNS

Welcome to the **SolaviseTech WordPress on AWS Lightsail Workshop**! This comprehensive hands-on workshop will guide you through deploying a fully functional WordPress website on AWS Lightsail with a custom domain using DuckDNS.

## 📋 Table of Contents

1. [Workshop Overview](#-workshop-overview)
2. [Prerequisites](#-prerequisites)
3. [What You'll Learn](#-what-youll-learn)
4. [Step 1: Setting Up AWS Lightsail](#step-1-setting-up-aws-lightsail)
5. [Step 2: Launching WordPress Instance](#step-2-launching-wordpress-instance)
6. [Step 3: Initial WordPress Configuration](#step-3-initial-wordpress-configuration)
7. [Step 4: Setting Up DuckDNS](#step-4-setting-up-duckdns)
8. [Step 5: Configuring SSL with Let's Encrypt](#step-5-configuring-ssl-with-lets-encrypt)
9. [Step 6: WordPress Security Hardening](#step-6-wordpress-security-hardening)
10. [Step 7: Performance Optimization](#step-7-performance-optimization)
11. [Troubleshooting](#-troubleshooting)
12. [Resource Cleanup](#-resource-cleanup)
13. [Additional Resources](#-additional-resources)

## 🎯 Workshop Overview

In this workshop, you'll deploy a production-ready WordPress site on AWS Lightsail with:
- **WordPress** running on a managed Lightsail instance
- **Custom domain** using DuckDNS (free dynamic DNS service)
- **SSL certificate** for secure HTTPS connections
- **Basic security hardening** and performance optimization

**Estimated Duration:** 2-3 hours  
**Difficulty Level:** Beginner to Intermediate

## ✅ Prerequisites

Before starting this workshop, ensure you have:

### Required Accounts
- [ ] **AWS Account** with billing enabled ([Create one here](https://aws.amazon.com/))
- [ ] **DuckDNS Account** ([Sign up here](https://www.duckdns.org/))

### Technical Requirements
- [ ] Basic understanding of web hosting concepts
- [ ] Familiarity with command line interface (CLI)
- [ ] SSH client installed on your computer
- [ ] Text editor (VS Code, Nano, Vim, etc.)

### Cost Considerations
- **AWS Lightsail:** Starting at $3.50/month for the smallest instance
- **DuckDNS:** Free
- **Let's Encrypt SSL:** Free

## 🎓 What You'll Learn

By the end of this workshop, you will:
- ✅ Understand AWS Lightsail and its benefits for small websites
- ✅ Deploy and configure WordPress on cloud infrastructure
- ✅ Set up a custom domain using DuckDNS
- ✅ Configure SSL certificates for secure connections
- ✅ Implement basic security measures for WordPress
- ✅ Optimize WordPress performance
- ✅ Troubleshoot common deployment issues

---

## Step 1: Setting Up AWS Lightsail

### 1.1 Access AWS Lightsail Console

1. **Sign in to AWS Console**
   - Navigate to [AWS Console](https://console.aws.amazon.com/)
   - Sign in with your AWS account credentials

2. **Open Lightsail**
   - Search for "Lightsail" in the AWS services search bar
   - Click on "Amazon Lightsail" to open the service

### 1.2 Choose Your Region

1. **Select Region**
   - Choose a region close to your target audience
   - Recommended regions: `us-east-1` (N. Virginia), `eu-west-1` (Ireland), `ap-southeast-1` (Singapore)
   - Note: Some features may vary by region

---

## Step 2: Launching WordPress Instance

### 2.1 Create Your Instance

1. **Click "Create Instance"**
2. **Select Instance Location**
   - Keep the default region or change if needed
   - Select the availability zone (usually Zone A is fine)

3. **Choose Instance Image**
   - Select **"Apps + OS"** tab
   - Choose **"WordPress"** (WordPress with Amazon Linux 2)

4. **Choose Instance Plan**
   - For this workshop, select the **$3.50/month** plan (1 vCPU, 512 MB RAM, 20 GB SSD)
   - This is sufficient for a small WordPress site

5. **Configure Additional Options**
   - **SSH Key Pair:** Create a new key pair or use existing
   - **Instance Name:** Give it a descriptive name (e.g., `my-wordpress-site`)

6. **Click "Create Instance"**

### 2.2 Wait for Instance Launch

- Wait 3-5 minutes for the instance to be in "Running" state
- The status will change from "Pending" to "Running"

### 2.3 Get Instance Information

1. **Note Your Public IP**
   - Click on your instance name
   - Copy the **Public IP address** (e.g., `18.206.12.34`)

2. **Test Basic Connectivity**
   - Open a web browser
   - Navigate to `http://YOUR_PUBLIC_IP`
   - You should see the WordPress installation page

---

## Step 3: Initial WordPress Configuration

### 3.1 Complete WordPress Setup

1. **Access WordPress**
   - Navigate to `http://YOUR_PUBLIC_IP` in your browser

2. **Choose Language**
   - Select your preferred language
   - Click "Continue"

3. **Database Configuration**
   - The database is pre-configured on Lightsail WordPress instances
   - Click "Let's go!" and then "Run the installation"

4. **Site Information**
   - **Site Title:** Enter your website name
   - **Username:** Create an admin username (avoid "admin")
   - **Password:** Use a strong password
   - **Your Email:** Enter your email address
   - **Search Engine Visibility:** Uncheck for now

5. **Click "Install WordPress"**

### 3.2 Access WordPress Admin

1. **Login to WordPress**
   - Navigate to `http://YOUR_PUBLIC_IP/wp-admin`
   - Use the credentials you just created

2. **Explore the Dashboard**
   - Familiarize yourself with the WordPress admin interface
   - Check that everything is working properly

---

## Step 4: Setting Up DuckDNS

### 4.1 Create DuckDNS Account

1. **Sign Up for DuckDNS**
   - Visit [DuckDNS.org](https://www.duckdns.org/)
   - Sign up using your preferred method (Google, GitHub, Reddit, etc.)

2. **Note Your Token**
   - After signing up, note your unique **token** (you'll need this later)

### 4.2 Create Your Domain

1. **Choose Domain Name**
   - Enter your desired subdomain (e.g., `mywordpresssite`)
   - Your full domain will be `mywordpresssite.duckdns.org`

2. **Set IP Address**
   - Enter your Lightsail instance's **public IP address**
   - Click "Update IP"

3. **Verify Domain**
   - Wait 5-10 minutes for DNS propagation
   - Test by visiting `http://yourdomain.duckdns.org`

### 4.3 Configure WordPress for New Domain

1. **SSH into Your Instance**
   ```bash
   ssh -i your-key.pem bitnami@YOUR_PUBLIC_IP
   ```

2. **Update WordPress URLs**
   ```bash
   # Navigate to WordPress directory
   cd /opt/bitnami/wordpress
   
   # Update WordPress configuration
   sudo wp config set WP_HOME 'http://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
   sudo wp config set WP_SITEURL 'http://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
   ```

3. **Restart Apache**
   ```bash
   sudo /opt/bitnami/ctlscript.sh restart apache
   ```

4. **Test Your Domain**
   - Visit `http://yourdomain.duckdns.org`
   - Verify WordPress loads correctly

---

## Step 5: Configuring SSL with Let's Encrypt

### 5.1 Install SSL Certificate

1. **SSH into Your Instance** (if not already connected)

2. **Run Bitnami's SSL Configuration Tool**
   ```bash
   sudo /opt/bitnami/bncert-tool
   ```

3. **Follow the Interactive Prompts**
   - Enter your domain: `yourdomain.duckdns.org`
   - Enable HTTP to HTTPS redirection: `Y`
   - Enable non-www to www redirection: `N` (DuckDNS doesn't support www)
   - Enter your email for Let's Encrypt notifications

4. **Wait for Certificate Installation**
   - The tool will automatically obtain and install the SSL certificate
   - This process takes 2-3 minutes

### 5.2 Verify SSL Configuration

1. **Test HTTPS Access**
   - Visit `https://yourdomain.duckdns.org`
   - Verify the padlock icon appears in your browser

2. **Update WordPress URLs for HTTPS**
   ```bash
   # Update URLs to use HTTPS
   sudo wp config set WP_HOME 'https://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
   sudo wp config set WP_SITEURL 'https://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
   
   # Restart Apache
   sudo /opt/bitnami/ctlscript.sh restart apache
   ```

3. **Test SSL Certificate**
   - Use [SSL Labs Test](https://www.ssllabs.com/ssltest/) to verify your certificate
   - You should get an A rating

---

## Step 6: WordPress Security Hardening

### 6.1 Update WordPress and Plugins

1. **Access WordPress Admin**
   - Login to `https://yourdomain.duckdns.org/wp-admin`

2. **Update WordPress Core**
   - Go to Dashboard → Updates
   - Install any available WordPress updates

3. **Update Plugins**
   - Navigate to Plugins → Installed Plugins
   - Update any plugins that need updating

### 6.2 Basic Security Configuration

1. **Change Default Admin Username**
   - If you used "admin" as username, create a new admin user
   - Delete the old "admin" user

2. **Install Security Plugin**
   ```bash
   # Install Wordfence Security plugin via CLI
   sudo wp plugin install wordfence --activate --path=/opt/bitnami/wordpress
   ```

3. **Configure Wordfence**
   - Go to WordPress Admin → Wordfence → Getting Started
   - Follow the setup wizard
   - Enable two-factor authentication

### 6.3 File Permissions

1. **Set Correct File Permissions**
   ```bash
   # Set secure file permissions
   sudo find /opt/bitnami/wordpress/ -type d -exec chmod 755 {} \;
   sudo find /opt/bitnami/wordpress/ -type f -exec chmod 644 {} \;
   sudo chmod 600 /opt/bitnami/wordpress/wp-config.php
   ```

---

## Step 7: Performance Optimization

### 7.1 Install Caching Plugin

1. **Install W3 Total Cache**
   ```bash
   sudo wp plugin install w3-total-cache --activate --path=/opt/bitnami/wordpress
   ```

2. **Configure Basic Caching**
   - Go to Performance → General Settings
   - Enable Page Cache
   - Enable Database Cache
   - Enable Object Cache

### 7.2 Optimize Images

1. **Install Image Optimization Plugin**
   ```bash
   sudo wp plugin install smush --activate --path=/opt/bitnami/wordpress
   ```

2. **Configure Smush**
   - Go to Smush → Dashboard
   - Run bulk smush to optimize existing images

### 7.3 Enable Gzip Compression

1. **Check if Gzip is Enabled**
   - Use [GZip Test Tool](https://www.giftofspeed.com/gzip-test/) to check compression

2. **If Not Enabled, Add to .htaccess**
   ```bash
   # Edit .htaccess file
   sudo nano /opt/bitnami/wordpress/.htaccess
   
   # Add these lines at the top:
   <IfModule mod_deflate.c>
   AddOutputFilterByType DEFLATE text/plain
   AddOutputFilterByType DEFLATE text/html
   AddOutputFilterByType DEFLATE text/xml
   AddOutputFilterByType DEFLATE text/css
   AddOutputFilterByType DEFLATE application/xml
   AddOutputFilterByType DEFLATE application/xhtml+xml
   AddOutputFilterByType DEFLATE application/rss+xml
   AddOutputFilterByType DEFLATE application/javascript
   AddOutputFilterByType DEFLATE application/x-javascript
   </IfModule>
   ```

---

## 🔧 Troubleshooting

### Common Issues and Solutions

#### Issue: WordPress Shows "Database Connection Error"
**Solution:**
```bash
# Restart MySQL service
sudo /opt/bitnami/ctlscript.sh restart mysql
sudo /opt/bitnami/ctlscript.sh restart apache
```

#### Issue: SSL Certificate Not Working
**Solution:**
```bash
# Re-run the SSL configuration tool
sudo /opt/bitnami/bncert-tool
```

#### Issue: Site Not Accessible via Domain
**Solutions:**
1. Check DNS propagation: Use [DNS Checker](https://dnschecker.org/)
2. Verify DuckDNS IP is correct
3. Check Lightsail firewall rules (ports 80 and 443 should be open)

#### Issue: WordPress Admin Redirects to IP Address
**Solution:**
```bash
# Update WordPress URLs in database
sudo wp option update home 'https://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
sudo wp option update siteurl 'https://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
```

#### Issue: "Too Many Redirects" Error
**Solution:**
```bash
# Check and fix WordPress URLs
sudo wp config set WP_HOME 'https://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
sudo wp config set WP_SITEURL 'https://yourdomain.duckdns.org' --path=/opt/bitnami/wordpress
```

### Useful Commands

```bash
# Check Apache status
sudo /opt/bitnami/ctlscript.sh status apache

# Check MySQL status  
sudo /opt/bitnami/ctlscript.sh status mysql

# View Apache error logs
sudo tail -f /opt/bitnami/apache2/logs/error_log

# Check disk space
df -h

# Check memory usage
free -m

# Test WordPress CLI
sudo wp --info --path=/opt/bitnami/wordpress
```

---

## 🧹 Resource Cleanup

When you're done with the workshop and want to avoid ongoing charges:

### 7.1 Delete Lightsail Instance

1. **Go to Lightsail Console**
2. **Select Your Instance**
3. **Click the three dots (⋮) menu**
4. **Select "Delete"**
5. **Confirm Deletion**

### 7.2 Clean Up DuckDNS

1. **Login to DuckDNS**
2. **Delete Your Domain** (optional)
3. **Keep Your Account** for future use

⚠️ **Warning:** Deleting your instance will permanently remove all data. Make sure to backup any important content first!

---

## 📚 Additional Resources

### Documentation
- [AWS Lightsail Documentation](https://lightsail.aws.amazon.com/ls/docs/)
- [WordPress Codex](https://codex.wordpress.org/)
- [DuckDNS FAQ](https://www.duckdns.org/faqs.jsp)
- [Let's Encrypt Documentation](https://letsencrypt.org/docs/)

### Useful Tools
- [GTmetrix](https://gtmetrix.com/) - Website performance testing
- [SSL Labs](https://www.ssllabs.com/ssltest/) - SSL certificate testing
- [DNS Checker](https://dnschecker.org/) - DNS propagation checking
- [WordPress CLI](https://wp-cli.org/) - Command line tool for WordPress

### Next Steps
- **Content Creation:** Start adding content to your WordPress site
- **Theme Customization:** Choose and customize a WordPress theme
- **Plugin Exploration:** Discover useful WordPress plugins
- **SEO Optimization:** Implement SEO best practices
- **Analytics:** Set up Google Analytics
- **Backup Strategy:** Implement regular backups
- **Monitoring:** Set up uptime monitoring

### Cost Optimization
- **Lightsail Scaling:** Monitor usage and scale up/down as needed
- **Snapshots:** Create periodic snapshots for backup
- **Load Balancing:** Consider Lightsail load balancer for high traffic
- **CDN:** Use Lightsail CDN for better performance

---

## 🎉 Congratulations!

You've successfully completed the WordPress on AWS Lightsail with DuckDNS workshop! You now have:

- ✅ A fully functional WordPress website
- ✅ Custom domain with HTTPS
- ✅ Basic security hardening
- ✅ Performance optimizations
- ✅ Understanding of cloud hosting concepts

**Share Your Success!** Tweet about your achievement and tag `@SolaviseTech` - we'd love to see what you've built!

---

## 🤝 Contributing

Found an issue or have suggestions for improvement? 

1. **Fork this repository**
2. **Create a feature branch**
3. **Submit a pull request**

We welcome contributions to make this workshop even better!

---

## 📄 License

This workshop content is available under the MIT License. See [LICENSE](LICENSE) for details.

---

**Workshop maintained by:** [SolaviseTech](https://github.com/kevshakes)  
**Last updated:** November 2024  
**Version:** 1.0
