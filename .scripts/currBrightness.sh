#!/bin/zsh

# Check the brightness on AMD, else NVIDIA
CURRENT=$(brightnessctl -d amdgpu_bl2 get || \
          brightnessctl -d nvidia_0 get)

# Compute value as percentage
RATIO=$(echo "scale=2; $CURRENT / 255" | bc)
PERCENTAGE=$(echo "scale=2; $RATIO * 100" | bc)

# Send notification
notify-send --urgency=low --app-name ">Current brightness<" "$PERCENTAGE %" 
