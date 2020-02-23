#!/bin/sh

sudo i2cget -y 1 0x0b 0x0d w | awk '{gsub("0x","")}{ gsub(/.{2}/,"& ")}  {printf ("TI Boot ROM version " "%d.%d\n", $1,$2)}'
