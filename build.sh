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
TEST="buils.sh"

# Telegram setup
push_message() {
    curl -s -X POST \
        https://api.telegram.org/bot1472514287:AAG9kYDURtPvQLM9RXN_zv4h79CIbRCPuPw/sendMessage \
        -d chat_id="-1001656503135" \
        -d text="$1" \
        -d "parse_mode=html" \
        -d "disable_web_page_preview=true"
}

push_document() {
    curl -s -X POST \
        https://api.telegram.org/bot1472514287:AAG9kYDURtPvQLM9RXN_zv4h79CIbRCPuPw/sendDocument \
        -F chat_id="-1001656503135" \
        -F document=@"$1" \
        -F caption="$2" \
        -F "parse_mode=html" \
        -F "disable_web_page_preview=true"
}

push_message "<b>Build bot is running.</b>
<b>Date:</b> <code>$DATE</code>"

echo -e "$blue    \nDownloading manifest and initialized repo.\n $nocol"
push_document "$TEST" "<b>Kernel for <code>$device</code> compiled succesfully!</b>
Total build time <b>((SECONDS / 60))</b> minute(s) and <b>((SECONDS % 60))</b> second(s) !

#logs #$device "
push_message "Downloading manifest and initialized repo"
cd ~
mkdir -p $HOME_DIR
cd ~/$HOME_DIR
repo init -u https://github.com/CraftRom/kernel -b nightly
repo sync


 for device in onclite surya; do

    mkdir -p ~/$HOME_DIR/chidori/$device
    
    (
	echo -e "$blue    \nStarting kernel compilation for $device\n $nocol"
	LOG="build-$device.log"
	BUILD_DATE=$(date '+%Y-%m-%d  %H:%M')
	 # Push message if build started
push_message "<b>Start building kernel for <code>$device</code></b>
<b>BuildDate:</b> <code>$BUILD_DATE</code>"
	 cd ~/$HOME_DIR/chidori/$device 
	 bash build.sh -n -t | tee $LOG
push_document "$LOG" "<b>Kernel for <code>$device</code> compiled succesfully!</b>
Total build time <b>((SECONDS / 60))</b> minute(s) and <b>((SECONDS % 60))</b> second(s) !

#logs #$device "
    
  done
