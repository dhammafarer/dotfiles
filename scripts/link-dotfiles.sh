#!/bin/bash

# Link dotfiles from a records in supplied file
# conf file is the first argument
conf=$1
dotfiles=$HOME/.dotfiles

# remove old .dotfiles if exists
[[ -f $dotfiles ]] && rm $dotfiles

# create empty .dotfiles
touch $dotfiles

# read records from file
cat $conf | while read line; do
  name=$(echo $line | awk '{print $1}')
  dir=$(echo $line | awk '{print $2}' | envsubst)
  file=$(echo $line | awk '{print $3}')
  src=$(echo $line | awk '{print $4}' | envsubst)

  path="$dir/$file"

  # if source file doesn't exist, exit with error
  #[[ ! -f "$src" ]] && echo "ERROR: $src does not exist"; exit 1;

  # Create target directory if doesn't exist
  [[ ! -e "$dir" ]] && mkdir -p $dir

  # Remove original file in location if exists
  [[ -f $path ]] && rm $path

  # Link source file to target path
  ln -fs $src $path

  # Add entry to ~/.dotfiles
  echo -e "$name\t$dir/$file" >> $dotfiles
done
