#!/bin/bash

echo -e "\n============================================================"
echo -e "Make sure you provide adequate checksum type for target file!"
echo -e "=============================================================\n"


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
