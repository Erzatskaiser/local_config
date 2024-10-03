#!/bin/zsh

# Var to store cache directory
NCSPOT_CACHE_DIRECTORY="/run/user/1000/ncspot"

# Function to join elements of an array
function join { local IFS="$1"; shift; echo "$*"; }

# Attempt to connect to cache
data=$(nc -W 1 -U $NCSPOT_CACHE_DIRECTORY/ncspot.sock 2> /dev/null) || \
  { echo No song currently playing; exit 0; } 

# Extract data from JSON
mode=$(jq '.mode|keys[0]' <<< $data)
title=$(jq '.playable.title' <<< $data)
artists=$(jq '.playable.artists' <<< $data)
album=$(jq '.playable.album' <<< $data)

# Clean mode
cleanMode=$(echo "$mode" | tr -d '"')

# Clean artist name
chars="]["
cleanArtist=$(echo "$artists" | sed "s/[$chars]//g" | tr -d '"')

# Craft the output sequence
echo $cleanMode: ${title:1:-1} \(${album:1:-1}\) by $cleanArtist
