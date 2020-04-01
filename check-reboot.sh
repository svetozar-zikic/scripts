#!/bin/bash

set -Eeou pipefail

VERSION=$(uname -r | grep -ie 'el[6-9]\|arch' | sed 's/.*/\L&/')
# REGEX='(\d{1,}\.?){3}((\d{1,}\.?){3})?'

case $VERSION in
  *arch*) 
  LAST_KERNEL=$(pacman -Q linux  | awk '{ print $2}' | sed 's/.arch/-arch/') 
  ;;
  *el[6-9]*) 
  LAST_KERNEL=$(rpm -q --last kernel | perl -pe 's/^kernel-(\S+).*/$1/' | head -1)
  ;;
  *)
  echo "Sorry, not arch or rhel/centos, not supported."
  exit 1
  ;;
esac

if [ -z "$LAST_KERNEL" ]; then
  echo "Couldn't determine installed kernel version, EXITING NOW!"
  exit 1
fi

RUNNING_KERNEL=$(uname -r) 
if [ -z "$RUNNING_KERNEL" ]; then
  echo "Couldn't determine running kernel version, EXITING NOW!"
  exit 1
fi

echo "latest installed kernel = $LAST_KERNEL"
echo "running kernel          = $RUNNING_KERNEL"

if [[ "$LAST_KERNEL" == "$RUNNING_KERNEL" ]];
  then
    echo "No reboot needed!"; 
  else
    echo "Reboot needed!"; 
fi
