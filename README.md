# Intersystem ODBC Syslog Deployment Guide

## Requirements
- Clean install of **Rocky Linux 9.5 (x86_64)**
- Internet access (for downloading packages from repositories)
- `root` privileges

> ISO image:  
Download and install from:  
**[Rocky-9.5-x86_64-boot.iso](https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.5-x86_64-boot.iso)**

---

## Step-by-step Installation

```bash
# 1. Install Git and OpenSSL
dnf install -y git openssl

# 2. Clone the deployment repository
git clone https://github.com/DesertGuano/intersystem_deploy.git

# 3. Change directory and make the script executable
cd intersystem_deploy
chmod +x run-deploy.sh

# 4. Run the deployment
./run-deploy.sh
```

---

## After Installation
Once complete, access the **Web UI** at:

```
http://<server-ip>:3000/setup
```

Use this page to:
- Set up the admin account
- Configure ODBC and syslog settings
- Apply static or DHCP network configuration
- View logs and system status

---

## What the Script Installs
- Node.js 18 (required for Express v5 and ODBC packages)
- PM2 with log rotation
- ODBC driver (InterSystems)
- Configurable dashboard with encrypted credentials
- Automatic systemd startup and firewall configuration

