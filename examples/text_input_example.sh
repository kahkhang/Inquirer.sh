#!/bin/bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

PARENT_DIR=$(dirname "$DIR")
source $PARENT_DIR/dev/text_input.sh

text_input "What's your first name" name

validate_disk_sizes() {
  local sizes=($(echo $1 | sed "s/,/ /g"))
  local total_size=0
  for disk_size in ${sizes[@]}; do
    total_size=$(($total_size+$disk_size))
  done

  if [ $total_size -le 100 ]; then
    echo true
  else
    echo false
  fi
}

text_input "Key in your local storage size (comma separated in mb, total not exceeding 100mb):" \
           disk_sizes "^[0-9]+(,[0-9]+)*$" "Enter valid disk sizes" validate_disk_sizes

disk_sizes=($(echo $disk_sizes | sed "s/,/ /g"))

echo "${#disk_sizes[@]} disks will be created"

for disk_size in ${disk_sizes[@]}; do
  echo "Disk size: ${disk_size}mb"
done

echo "Hello $name"
echo "$(join disk_sizes ",")"
