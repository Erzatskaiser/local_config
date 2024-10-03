#!/bin/zsh

# Obtain user input for wifi name
name=$1
isKnown=0

# Rescan available access points
nmcli device wifi rescan

# Check whether name is in stored connections
known=$(nmcli -t connection show)
while IFS= read -r line; 
  do
    IFS=":"
    read -ra out <<< "$line"
    
    # Check whether the name matches
    if [ "$name" == "$out" ]; then
      isKnown=1
      break
    fi
done <<< $(echo "$known")

# If the network is known, attempt to connect (Error is printed else)
if [ $isKnown -eq 1 ]; then
  nmcli device wifi connect $name >> /dev/null 2>&1 || $(read -sp "Key:" psswd && \
    printf "\n"; nmcli device wifi connect "$name" password "$psswd")
# If the network is not known
else
  read -sp "Key:" passwd 
  printf "\n"
  nmcli device wifi connect $name password \"$psswd\"
fi

