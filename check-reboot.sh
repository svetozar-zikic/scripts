#!/bin/bash

VERSION=$(uname -r | grep -ie 'el[6-9]\|arch' | sed 's/.*/\L&/')
REGEX='(\d{1,}\.?){3}((\d{1,}\.?){3})?'

case $VERSION in
  *arch*) 
  INSTALLED_KERNEL=$(pacman -Q linux | awk '{ print $2}' | sed 's/-/./' | grep -Po $REGEX)
  echo "INSTALLED_kernel = $INSTALLED_KERNEL"
  ;;
  *el[6-9]*) 
  INSTALLED_KERNELS=($(yum list installed | grep '^kernel\.' | awk '{ print $2}'))
  INSTALLED_KERNEL=0 

  MAX_INDEX=0
  MAX_LENGTH=${#INSTALLED_KERNELS[$MAX_INDEX]}
  
  for i in ${!INSTALLED_KERNELS[@]}
  do
    if [[ $MAX_LENGTH -lt ${#INSTALLED_KERNELS[$i]} ]];
    then
      MAX_INDEX=$i
      MAX_LENGTH=${#INSTALLED_KERNELS[$MAX_INDEX]}
    fi
  done
  
  find_latest_kernel(){
  LATEST_KERNEL=${INSTALLED_KERNELS[0]}
  for i in ${INSTALLED_KERNELS[@]}
  do
    if [[ "$LATEST_KERNEL" < "$i" ]];
    then
      LATEST_KERNEL=$i
    fi
  done
  INSTALLED_KERNEL=$(echo $LATEST_KERNEL | sed 's/-/./' | grep -Po $REGEX)
  }
  
  find_longest_kernel(){
  INSTALLED_KERNEL=$(echo ${INSTALLED_KERNELS[$MAX_INDEX]} | sed 's/-/./' | grep -Po $REGEX)
  }
  
  case $MAX_INDEX in
    0) find_latest_kernel
    ;;
    *) find_longest_kernel
    ;;
  esac

  if [ -z "$INSTALLED_KERNEL" ];
    then  
      echo "Couldn't determine installed kernel version, EXITING NOW!"
      exit 1
  fi
  echo "INSTALLED_kernel = $INSTALLED_KERNEL"
  ;;
  *) echo "Sorry, not arch or rhel/centos, not supported." && exit
  ;;
esac

RUNNING_KERNEL=$(uname -r | sed 's/-/./' | grep -Po $REGEX) 
if [ -z "$RUNNING_KERNEL" ];
  then
    echo "Couldn't determine running kernel version, EXITING NOW!"
    exit 1
fi
echo -e "RUNNING_kernel   = $RUNNING_KERNEL"

if [ "$INSTALLED_KERNEL" = "$RUNNING_KERNEL" ];
  then
    echo "all good! no reboot needed"; 
  else
    echo "you need to reboot!"; 
fi
