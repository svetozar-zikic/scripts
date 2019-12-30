#!/bin/bash

VERSION=$(uname -r | grep -ie 'el[6-9]_\|arch')
REGEX='(\d{1,}\.?){3}(-(\d{1,}\.?){3})?'

case $VERSION in
  *arch*) INSTALLED_KERNEL=$(pacman -Q linux | awk '{ print $2}' | grep -Po $REGEX)
  echo "INSTALLED_kernel = $INSTALLED_KERNEL"
  ;;
  *el[6-9]*) 
  # needs more work on determining what's actually the latest installed version. sort doesn't seem to produce consistent result.
  INSTALLED_KERNEL=$(yum list installed | grep '^kernel\.' | sort -k2 | tail -n1 | awk '{ print $2}'  | grep -Po $REGEX)
  echo "INSTALLED_kernel = $INSTALLED_KERNEL"
  ;;
  *) echo "Sorry, not arch or rhel/centos, not supported." && exit
  ;;
esac

RUNNING_KERNEL=$(uname -r | grep -Po $REGEX) 
echo -e "RUNNING_kernel   = $RUNNING_KERNEL"
if [ "$INSTALLED_KERNEL" = "$RUNNING_KERNEL" ];
  then
    echo "all good! no reboot needed"; 
  else
    echo "you need to reboot!"; 
fi
