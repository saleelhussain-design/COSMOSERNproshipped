#!/bin/bash
# ==============================================================================
# CosmosERP Desktop Build Script
# ==============================================================================

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting CosmosERP Desktop Build Process...${NC}"

# 1. Prepare Build Directory
BUILD_DIR="cosmos_desktop"
cd "$BUILD_DIR" || { echo -e "${RED}[!] Failed to enter build directory${NC}"; exit 1; }

# 2. Install Dependencies
echo -e "${BLUE}[*] Installing dependencies...${NC}"
npm install

# 3. Build and Package
echo -e "${BLUE}[*] Building the AppImage and .deb package...${NC}"
# We use electron-builder to create the distribution files
# This will create a dist/ folder with the AppImage and .deb
npm run dist

# 4. Move Distribution Files to Root /build/distribution folder
cd ..
mkdir -p build/distribution
cp -r cosmos_desktop/dist/* build/distribution/
echo -e "${GREEN}Build Successful! Distribution files are in build/distribution/${NC}"
