# smbvga

goal of this project is to learn more about the dead battery of my laptop. (and maybe "how set my house on fire")

i found out that i can plug 3 cables into the vga port of my laptop and talk to the battery via i2c-tools on linux.

primary source of information so far has been the blog karosium.com 

so far, i managed to get into (what i believe is) full access mode.
the chip on my battery is a bq8030 with sanyo firmware.

battery pinout:

                 |  |       |   |   |   |   | 
                 
                 + +       SCL SDA  T? GND GND

 vga pinout:                15   12          5 




if your distro has it in the repos: 

sudo apt-get install i2c-tools

