#!/bin/sh

sudo i2cget -y 1 0x0b 0x08 w  | awk -W posix '{printf ("%d\n", $1-2732)}' | awk ' { gsub(/.{2}/,"&,"); print "Temperature: ", $1 " ºC" } '
