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

push_document() {
    curl -s -X POST \
        https://api.telegram.org/bot1472514287:AAG9kYDURtPvQLM9RXN_zv4h79CIbRCPuPw/sendDocument \
        -F chat_id="-1001656503135" \
        -F document=@"$1" \
        -F caption="$2" \
        -F "parse_mode=html" \
        -F "disable_web_page_preview=true"
}

echo -e "$blue    \nDownloading manifest and initialized repo.\n $nocol"
cd ~
mkdir -p $HOME_DIR
cd ~/$HOME_DIR
repo init -u https://github.com/CraftRom/kernel -b nightly
repo sync


 for device in onclite surya; do

    mkdir -p ~/$HOME_DIR/chidori/$device
    
    (
	echo -e "$blue    \nStarting kernel compilation for $device\n $nocol"
	BUILD_DATE=$(date '+%Y-%m-%d  %H:%M')
	 # Push message if build started
	 push_message "<b>Start building kernel for <code>$device</code></b>
	 <b>BuildDate:</b> <code>$BUILD_DATE</code>"
	 cd ~/$HOME_DIR/chidori/$device 
	 bash build.sh -n -t
	
	push_message "<b>Kernel for <code>$device</code> compiled succesfully!</b>
	  Completed build <b>((SECONDS / 60))</b> minute(s) and <b>((SECONDS % 60))</b> second(s) !</code>"
    )
    
  done
