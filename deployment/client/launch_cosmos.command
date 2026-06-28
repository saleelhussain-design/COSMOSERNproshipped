#!/bin/bash
# This script launches CosmOS ERP in a standalone window (App Mode)
# It works if Google Chrome or Microsoft Edge is installed.

URL="http://CosmOS.local:8081"

if [ -d "/Applications/Google Chrome.app" ]; then
    open -a "Google Chrome" --args "--app=$URL"
elif [ -d "/Applications/Microsoft Edge.app" ]; then
    open -a "Microsoft Edge" --args "--app=$URL"
else
    echo "Please install Google Chrome or Microsoft Edge for the best experience."
    open "$URL"
fi
