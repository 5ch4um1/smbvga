got a bit frustrated with boot rom mode and my head was about to explode...
so i thought i'd see what i can find out about the other side of the communication,
the ec that's on the mainboard.

sudo modprobe ec_sys write_support=1

  sudo hexdump -C /sys/kernel/debug/ec/ec0/io

  00000000  00 01 00 00 00 01 00 00  00 00 00 00 00 00 00 00  |................|
  00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  00000020  32 84 0c 3d 09 05 00 a2  00 00 00 00 00 00 00 00  |2..=............|
  00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  00000080  00 00 00 00 00 0a 00 83  00 00 00 00 00 00 00 00  |................|
  00000090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  000000a0  00 00 00 23 c1 00 00 64  63 00 00 09 69 17 00 00  |...#...dc...i...|
  000000b0  31 2d 00 00 00 00 00 00  0c 0a 00 97 70 00 00 00  |1-..........p...|
  000000c0  00 80 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  000000d0  00 00 00 00 00 00 ff 00  00 00 00 00 00 00 00 00  |................|
  000000e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  00000100


that is without the battery. i compiled ec_access from 

https://github.com/torvalds/linux/tree/master/tools/power/acpi/tools/ec

and let it run in a while loop with the s option:

while true; do sudo ./ec_access -rs 1 ; echo " " ; done > changes

while inserting the battery to see what changes, if i could maybe spot the charger
turning on and off again, but no luck yet.
