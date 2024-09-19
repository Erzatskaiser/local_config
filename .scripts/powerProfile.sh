# Take input to determine power profile to run
profile=$1

# User requests for help
if [ "$profile" == "help" ]; then
  echo "The available options are: Quiet, Balanced, and Performance"
# Execute the command, supress output
else 
  asusctl profile -P $profile >> /dev/null 2>&1
fi
