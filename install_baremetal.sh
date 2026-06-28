#!/bin/bash
# ==============================================================================
# CosmosERP Master Installer (Bare-Metal)
# ==============================================================================

# --- CONFIGURATION ---
DB_ROOT_PASS="admin123"
SITE_NAME="cosmos.local"
ADMIN_PASS="admin123"
# ---------------------

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================================${NC}"
echo -e "${BLUE}       CosmosERP: Single-Click Installation Engine      ${NC}"
echo -e "${BLUE}========================================================${NC}"

# 1. Root check
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[!] Please run with sudo: sudo ./install_baremetal.sh${NC}"
  exit 1
fi

# 2. System Dependencies
echo -e "\n${BLUE}[Step 1/5] Installing System Dependencies...${NC}"
apt-get update && apt-get install -y git python3-dev python3-pip python3-venv \
    mariadb-server mariadb-client redis-server curl software-properties-common \
    libmysqlclient-dev build-essential libssl-dev libffi-dev

# 3. Node.js & Yarn
echo -e "\n${BLUE}[Step 2/5] Installing Node.js 18 & Yarn...${NC}"
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
npm install -g yarn

# 4. MariaDB Config
echo -e "\n${BLUE}[Step 3/5] Configuring Database...${NC}"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';"
mysql -e "FLUSH PRIVILEGES;"
cat <<EOF > /etc/mysql/mariadb.conf.d/50-frappe.cnf
[mysqld]
innodb-check-optimize-monitor=ON
innodb-file-per-table=1
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
innodb_file_format=Barracuda
innodb_large_prefix=1
innodb_default_row_format=DYNAMIC
EOF
systemctl restart mariadb

# 5. Bench Setup (Run as the actual user)
REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~$REAL_USER)
echo -e "\n${BLUE}[Step 4/5] Initializing Bench for $REAL_USER...${NC}"
sudo -u $REAL_USER pip3 install --user frappe-bench
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$USER_HOME/.bashrc"

# 6. App Deployment
echo -e "\n${BLUE}[Step 5/5] Deploying CosmosERP App...${NC}"
sudo -u $REAL_USER bash <<EOF
    export PATH="\$HOME/.local/bin:\$PATH"
    cd $USER_HOME
    bench init cosmos-bench --frappe-branch version-15 --skip-redis-config-check
    cd cosmos-bench
    bench new-site $SITE_NAME --mariadb-root-password $DB_ROOT_PASS --admin-password $ADMIN_PASS
    
    # Integration with the current repo
    # (Assumes the user has cloned the repo into their home folder)
    REPO_PATH="$USER_HOME/frappe_docker/cosmos_core"
    if [ -d "\$REPO_PATH" ]; then
        bench get-app "\$REPO_PATH"
    else
        echo "Repo not found at \$REPO_PATH, skipping app install."
    fi
    
    bench --site $SITE_NAME install-app cosmos_core
EOF

# 7. Post-Install Verification
echo -e "\n${BLUE}========================================================${NC}"
echo -e "${GREEN}VERIFYING INSTALLATION...${NC}"
echo -e "${BLUE}========================================================${NC}"

# Check if services are active
services=("mariadb" "redis-server")
for s in "\${services[@]}"; do
    if systemctl is-active --quiet "\$s"; then
        echo -e "[${GREEN}OK${NC}] \$s is running."
    else
        echo -e "[${RED}FAIL${NC}] \$s is NOT running."
    fi
done

echo -e "\n${GREEN}SUCCESS! Your system is now a CosmosERP Host.${NC}"
echo -e "Run: ${BLUE}cd $USER_HOME/cosmos-bench && bench start${NC}"
echo -e "URL: ${BLUE}http://$SITE_NAME:8000${NC}"
echo -e "========================================================\n"
