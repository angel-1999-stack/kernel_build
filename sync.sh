#!/bin/bash
#
# Compile script for kernel
# Copyright (C) 2022 Craft Rom.

SECONDS=0 # builtin bash timer

#Set Color
blue='\033[0;34m'
grn='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
txtbld=$(tput bold)
txtrst=$(tput sgr0) 

DATE=$(date '+%Y-%m-%d  %H:%M')
HOME_DIR="craftrom"

# Telegram setup
push_message() {
    curl -s -X POST \
        https://api.telegram.org/bot1472514287:AAG9kYDURtPvQLM9RXN_zv4h79CIbRCPuPw/sendMessage \
        -d chat_id="-1001656503135" \
        -d text="$1" \
        -d "parse_mode=html" \
        -d "disable_web_page_preview=true"
}

push_message "<b>Build bot is running.</b>
<b>Date:</b> <code>$DATE</code>"

echo -e "$blue    \nDownloading manifest and initialized repo.\n $nocol"
push_message "Downloading manifest and initialized repo"
cd ~
mkdir -p $HOME_DIR
cd ~/$HOME_DIR
repo init -u https://github.com/CraftRom/kernel -b nightly
repo sync --detach --current-branch --no-tags --force-remove-dirty --force-sync
