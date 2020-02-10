#!/bin/sh

sudo i2cget -y 1 0x0b 0x17 w | awk ' {print "Cycle count: " substr($1,3)}'
