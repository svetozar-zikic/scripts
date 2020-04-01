#!/bin/bash

WARN(){
echo "This script should be invoked with 1 argument!"
echo "Usage: $0 {{ fqdn | hostname | ip }}"
echo "Example: $0 {{ target_dns_server}}"
exit 1
}

if [ $# != 1 ];
then
  WARN
fi

echo "-- localhost -- "
echo -n "testing local dns servers: "
dig +short ${1}

# locations
LOCATIONS=(SD LV MI)

# dns server ip's per location
DNS_IP_SD=()

# dns server hostname per location
DNS_NAME_SD=()

for i in ${LOCATIONS[@]};
do
  echo "-- $i --"
    declare IP="DNS_IP_$i[@]"
    declare NAME="DNS_NAME_$i[@]"
    for j in ${!IP}
    do
      echo -n "testing on $j: "
      dig +short ${1} @$j
    done
    for k in ${!NAME}
    do
      echo -n "testing on $k: "
      dig +short ${1} @$k
    done
done
