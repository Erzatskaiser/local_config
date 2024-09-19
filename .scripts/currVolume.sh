# Obtain current volume, keep only numerical value
CURRENT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -E -o '[0-9.]+')

# Compute the volume as a percentage
PERCENT=$(bc -l <<<"$CURRENT*100")

# Write the notification
notify-send --urgency=low --app-name ">Current volume<" "$PERCENT %"
