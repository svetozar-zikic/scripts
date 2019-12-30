#!/bin/bash

curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' -e '/^$/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist
