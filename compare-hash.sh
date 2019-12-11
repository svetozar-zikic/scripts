#!/bin/bash

#Usage  : ./compare-hash.sh {{ file }} {{ md5sum || sha1sum || sha256sum }}
#Example: ./compare-hash.sh README.md 3a64eeb45a83030f40de6cf7bf55d71e60f9e577

if [ ${#2} -eq 32 ];
 then CHECK=md5sum
elif [ ${#2} -eq 40 ];
 then CHECK=sha1sum
elif [ ${#2} -eq 64 ];
 then CHECK=sha256sum
else
 echo "Provided hash is not a sha256sum, nor sha1sum, nor md5sum!!!"
 echo -e "Exiting now...\n"
 exit 1
fi

if [ $( $CHECK $1 | awk '{ print $1}') == $2 ]; 
  then 
    echo 'match, all good!'; 
  else 
    echo 'NO MATCH!!!'; 
fi
