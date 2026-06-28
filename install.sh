#!/bin/bash

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================================${NC}"
echo -e "${BLUE}       CosmOS: Unified Installation Engine           ${NC}"
echo -e "${BLUE}========================================================${NC}"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[!] Please run this script with sudo (e.g., sudo ./install.sh)${NC}"
  exit 1
fi

echo -e "\nChoose your installation method:"
echo -e "1) ${GREEN}Bare Metal${NC} (Direct OS installation - High performance)"
echo -e "2) ${GREEN}Docker${NC} (Containerized - Easy to move/scale)"
echo -e "\nSelection [1-2]: "
read choice

case $choice in
  1)
    echo -e "\nStarting Bare Metal Installation..."
    bash /home/saleel/git/cosmos_project/frappe_docker/bare_metal/bare_metal_install.sh
    ;;
  2)
    echo -e "\nStarting Docker Installation..."
    # Re-use the previous smart logic but point to the new /docker path
    bash /home/saleel/git/cosmos_project/frappe_docker/deployment/server/setup.sh
    ;;
  *)
    echo -e "${RED}Invalid choice. Exiting.${NC}"
    exit 1
    ;;
esac
