#!/bin/bash

VERSION=$(cat /etc/*-release | head -n1)

case $VERSION in
  arch*) INSTALLED_KERNEL=$(pacman -Q linux | awk '{ print $2}' | grep -Po '(\d{1,}\.){2}\d{1,}')
  echo "INSTALLED_kernel = $INSTALLED_KERNEL"
  ;;
  CentOS*) INSTALLED_KERNEL=$(yum list installed | grep '^kernel\.' | sort -k2 | tail -n1 | awk '{ print $2}'  | grep -Po '(\d{1,}\.?){3}-(\d{1,}\.){3}')
  echo "INSTALLED_kernel = $INSTALLED_KERNEL"
  ;;
  *) echo "Sorry, not arch or rhel/centos, not supporeted."
esac

RUNNING_KERNEL=$(uname -r | grep -Po '(\d{1,}\.?){3}-(\d{1,}\.){3}') 
echo -e "RUNNING_kernel = $RUNNING_KERNEL"

if [ "$INSTALLED_KERNEL" = "$RUNNING_KERNEL" ];
  then
    echo "all good! no reboot needed"; 
  else
    echo "you need to reboot!"; 
fi
