#!/bin/bash

#sha256sum lengh
LEN=64

echo -e "Make sure you provide sha256sum for target file!\n"

if [ $(echo ${#2}) -ne $LEN ];
  then
    echo "Provided hash is not sha256sum!! Length not equal 64 chars!!!!"
    echo -e "Exiting now...\n"
    exit
fi

if [ $(sha256sum $1 | awk '{ print $1}') == $2 ]; 
  then 
    echo 'match, all good!'; 
  else 
    echo 'NO MATCH!!!'; 
fi
