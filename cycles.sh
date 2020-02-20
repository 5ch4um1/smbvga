#!/bin/sh

sudo i2cget -y 1 0x0b 0x17 w | awk -W posix '{printf ("Cycle Count: " "%d\n", $1)}'
