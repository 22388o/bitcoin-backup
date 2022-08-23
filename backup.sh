#!/bin/bash

# Check if inotify-tools is installed otherwise
# it installs automatically.
if ! which inotifywait &> /dev/null ; then
    apt-get install inotify-tools -y
fi

mkdir -p ~/.bk
if [ ! -f "/media/$label/wallet.dat" ]; then
    cp ./configs.json ~/.bk/configs.json
fi

# Get the label of the device that 
# will be used as a backup.
echo $(date +"%Y-%m-%d-%H:%M:%S") "Loading configuration file."
label=$(cat ~/.bk/configs.json | jq -r ."device")
if [ !label ]; then
    echo $(date +"%Y-%m-%d-%H:%M:%S")  "You need to configure the configuration file in: ~/.bk/configs.json."
    exit
fi

wallet=$(cat ~/.bk/configs.json | jq -r ."wallet")
if [ !label ]; then
    echo $(date +"%Y-%m-%d-%H:%M:%S")  "You need to configure the configuration file in: ~/.bk/configs.json."
    exit
fi

# Search for the device with the 
# configuration file label.
echo $(date +"%Y-%m-%d-%H:%M:%S") "Searching device: $label." 
device=$(blkid | grep $label | awk -F':' '{print $1}') 

if mount | grep $device &> /dev/null; then
    echo $(date +"%Y-%m-%d-%H:%M:%S") "Backup device already mounted."
else 
    mkdir -p /media/$label
    mount $device /media/$label
fi

while true; do
    if [ ! -f "/media/$label/wallet.dat" ]; then
        cp $wallet /media/$label
    fi
    inotifywait $wallet
    cp $wallet /media/$label
done