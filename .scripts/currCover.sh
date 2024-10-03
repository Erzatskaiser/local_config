#!/bin/zsh

# Var to store cache directory
NCSPOT_CACHE_DIRECTORY="/run/user/1000/ncspot"

# Function to join elements of an array
function join { local IFS="$1"; shift; echo "$*"; }

# Attempt to connect to cache
data=$(nc -W 1 -U $NCSPOT_CACHE_DIRECTORY/ncspot.sock 2> /dev/null) || \
  { echo ~/.config/aesthetics/profilePicture.png; exit 0; } 

# Extract data from JSON
cover=$(jq '.playable.cover_url' <<< $data)
name=$(jq '.playable.album_id' <<< $data)
mode=$(jq '.mode|keys[0]' <<< $date)

# Clean data from JSON
cleanCover=$(echo "$cover" |  tr -d '"')
cleanName=$(echo "$name" | tr -d '"')
cleanMode=$(echo "$mode" | tr -d '"')

# Image file already exists: Rotate image
if [ -e ~/.config/aesthetics/coverArt/"$cleanName.png" ]; then
  
  # Rotations have large impact on performance,
  #echo ~/Customizations/coverArt/"$cleanName.png"
  #exit 3

  # Rotate the image by 90 degrees
  #convert ~/Customizations/coverArt/"$cleanName.png" -rotate 90 \
   #-gravity center ~/Customizations/coverArt/"$cleanName.png" >> /dev/null 2>&1
  
  # Rotation by non 90 degrees increments
  convert ~/.config/aesthetics/coverArt/"$cleanName.png" -distort SRT 60 \
    ~/.config/aesthetics/coverArt/"$cleanName.png"
  

# Image file does not exist: download image and round
else

  # Download the image file, throwing an error message else
  curl -s $cleanCover > ~/.config/aesthetics/coverArt/"$cleanName.png" || \
    { echo ~/.config/aesthetics/profilePicture.png; exit 1; }
 
  # Get image size
  rawSize=$(identify -ping -format '%w %h')
  IFS=' ' read -ra ARRAY <<< rawSize
  height=${ARRAY[1]}
  width=${ARRAY[2]}

  # Transform image to circular cutout
    convert ~/.config/aesthetics/coverArt/"$cleanName.png" \
    -gravity Center \
    \( -size 640x640 \
        xc:Black \
        -fill White \
        -draw 'circle 300 300 300 0' \
        -alpha Copy \
    \) -compose CopyOpacity -composite \
    -trim ~/.config/aesthetics/coverArt/"$cleanName.png" >> /dev/null 2>&1
fi 

# Echo the path to the image
echo ~/.config/aesthetics/coverArt/"$cleanName.png"

