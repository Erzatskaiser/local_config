# Check the brightness on AMD, else NVIDIA
CURRENT=$(brightnessctl -d amdgpu_bl1 get || \
          brightnessctl -d nvidia_0 get)

notify-send --urgency=low --app-name ">Current brightness<" "$CURRENT %" 
