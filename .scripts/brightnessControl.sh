#!/bin/zsh  

# Take in input to determine increase or decrease
action=$1

# Attempt to increase brightness on AMD, else try Nvidia
if [[ "$action" == "increase" ]]; then
  brightnessctl -q -d amdgpu_bl2 set +5% >/dev/null 2>&1 || \
    brightnessctl -q -d nvidia_0 set +5% >/dev/null 2>&1

# Attempt to decraese brightness on AMD, else try Nvidia
elif [[ "$action" == "decrease" ]]; then
  brightnessctl -q -d amdgpu_bl2 set 5%- >/dev/null 2>&1 || \
    brightnessctl -q -d nvidia_0 set 5%- >/dev/null 2>&1

# Unknown parameter
else
  echo "Unknown parameter" $action
fi 
