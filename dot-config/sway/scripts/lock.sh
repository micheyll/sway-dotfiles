# put task in background
swayidle \
    timeout 5 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# lcok screen
swaylock -c000000
