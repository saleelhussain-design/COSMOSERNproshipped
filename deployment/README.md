# CosmOS ERP Deployment Guide

This folder contains all necessary files to install the CosmOS ERP server and client.

## 🚀 Server Installation
1. Copy the `server` folder to your server.
2. Open a terminal in the `server` folder.
3. Run the setup script:
   ```bash
   sudo ./setup.sh
   ```
*Note: Ensure you have Docker installed and the image `custom/CosmOS:v16.23.2` available.*

## 💻 Client Installation
1. Copy the `client` folder to the client machine.
2. Open a terminal in the `client` folder.
3. Run the installation script:
   ```bash
   sudo ./install_client.sh
   ```
*Note: This script updates the /etc/hosts file and creates a desktop shortcut.*

## 🔗 Accessing the App
Open your browser and go to: `http://CosmOS.local:8081`

## 📖 User Manual
The CosmOS User Manual is available in two ways:
1. **In-App:** Navigate to the "User Manual" workspace within the CosmOS ERP interface.
2. **PDF Version:** The manual is located at `/assets/CosmOS_core/public/CosmOS_User_Manual.pdf` on the server.

## 🖥️ Native Desktop Option (Electron)
If you want a true standalone application (no browser tabs, no address bar), use the Electron wrapper.

Refer to [README_ELECTRON.md](./README_ELECTRON.md) for build instructions.

## 🍎 Mac-Specific Launch
If you are on a Mac, simply double-click `launch_CosmOS.command`. It will open the app in a standalone window without the browser address bar, giving it a native application feel.
