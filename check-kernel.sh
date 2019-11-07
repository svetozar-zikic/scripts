#!/bin/bash

a=$(pacman -Q linux | awk '{ print $2}' | grep -P -o '(\d{1,}\.){2}\d{1,}')
b=$(uname -r | grep -P -o '(\d{1,}\.){2}\d{1,}') 

if [ $a == $b ];
  then
    echo "all good! no reboot needed"; 
  else
    echo "you need to reboot!"; 
fi
