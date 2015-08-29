#BPI-Mainline-Snappy

This is a example of creating a snappy ubuntu core 15.04 image for M2 with BPI-Mainline uboot and kernel. If you want  make other device image,  please replace bsp , kernel modules and other files with your own.

**Create image**

 `$ ./build.sh`

**Download image**

 `$ sudo dd if=my_bananapi.img of=/dev/sdX bs=32M`

**Download bootloader**

 `$ sudo dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=1024 seek=8`
