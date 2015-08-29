setenv kernel_addr	0x47000000
setenv initrd_addr 	0x48000000
setenv fdt_addr		0x43000000
setenv system_txt_addr  0x44000000

setenv bootpart 0:1

echo Loading Snappy config ...;
#import snappy env
load mmc ${mmcdev}:${mmcpart} ${system_txt_addr} snappy-system.txt; env import -t ${system_txt_addr};

if test "${snappy_mode}" = "try"; then
  if test -e mmc ${bootpart} ${snappy_stamp}; then
    if test "${snappy_ab}" = "a"; then 
    	echo setenv to b;
      setenv snappy_ab "b"; 
    else 
      echo setenv to a;
      setenv snappy_ab "a"; 
    fi;
  else
    echo fatwrite ${snappy_stamp};
    fatwrite mmc ${mmcdev}:${mmcpart} 0x0 ${snappy_stamp} 0;
  fi;
fi;


echo Loading Snappy kernel ...;
# Boostrap device binary tree, kernel and raw initrd

load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${snappy_ab}/dtbs/${fdtfile};
load mmc ${mmcdev}:${mmcpart} ${kernel_addr} ${snappy_ab}/vmlinuz;
load mmc ${mmcdev}:${mmcpart} ${initrd_addr} ${snappy_ab}/initrd.img; setenv initrd_size ${filesize};

echo Setting Snappy kernel ...;
setenv bootargs console=ttyS0,115200 console=tty1 root=/dev/disk/by-label/system-${snappy_ab} ${snappy_cmdline}

echo Loading Snappy kernel ...;
bootz ${kernel_addr} ${initrd_addr}:${initrd_size} ${fdt_addr}

