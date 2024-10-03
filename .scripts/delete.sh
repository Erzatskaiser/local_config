# Take input on file/folder to delete
target=$1


# Has folder flag been set
if [ $1 == "-R" ]; then
  [ -d $2 ] && mv $2 ~/.Trash
else 
  [ -f $1 ] && mv $1 ~/.Trash
fi
