#!/bin/bash

# Function to try getting a property
try_get_property() {
    local interface=$1
    local property=$2
    gdbus call --session \
        --dest com.github.wwmm.easyeffects \
        --object-path /com/github/wwmm/easyeffects \
        --method org.freedesktop.DBus.Properties.Get \
        "$interface" "$property" 2>/dev/null
}

# Try different possible interfaces and properties
interfaces=("com.github.wwmm.easyeffects" "org.gtk.Application" "org.freedesktop.Application")
properties=("current-preset" "preset" "active-preset" "CurrentPreset")

for interface in "${interfaces[@]}"; do
    for property in "${properties[@]}"; do
        result=$(try_get_property "$interface" "$property")
        if [ $? -eq 0 ]; then
            echo "$result" | sed "s/^[^']*'//; s/'.*//; s/^[[:space:]]*//; s/[[:space:]]*$//"
            exit 0
        fi
    done
done

# If we couldn't get the preset, try to get all properties
for interface in "${interfaces[@]}"; do
    all_properties=$(gdbus call --session \
        --dest com.github.wwmm.easyeffects \
        --object-path /com/github/wwmm/easyeffects \
        --method org.freedesktop.DBus.Properties.GetAll \
        "$interface" 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "All properties for $interface:"
        echo "$all_properties"
        exit 0
    fi
done

echo "Unable to get profile or properties"
exit 1
