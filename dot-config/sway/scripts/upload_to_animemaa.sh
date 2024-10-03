#!/bin/bash

# Check if a file was provided
if [ $# -eq 0 ]; then
    notify-send "Error" "No file selected"
    exit 1
fi

file="$1"

# Upload the file
response=$(curl -s -F "files[]=@$file" https://img.animemaa.fi/upload.php)

# Extract the URL using jq
url=$(echo "$response" | jq -r '.files[0].url')

# Copy URL to clipboard
echo -n "$url" | wl-copy

# Send notification
notify-send "File uploaded" "URL copied to clipboard"
