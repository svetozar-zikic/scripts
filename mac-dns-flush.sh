#!/bin/bash

# flush cache
echo -e 'Flushing dns cache...'
dscacheutil -flushcache

# kill all instances of dnsresponder
echo -e 'Killing all instances of mdnsresponder, please enter your password below'
sudo killall -HUP mDNSResponder
