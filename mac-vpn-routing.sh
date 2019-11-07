#!/bin/sh
# delete default route
route delete -net default -interface utun2
# add route for all traffic trough wireless/wired
route add -net 0.0.0.0 -interface en0
# add route for ntent vpn specific
route add -net 10.0.0.0 -netmask 255.0.0.0 -interface utun2
