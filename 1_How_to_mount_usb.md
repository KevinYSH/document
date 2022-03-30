How to mount the USB disk in system

### 1. Detect your USB drive
After you plug in your USB device to the USB port, Linux system adds a new block device into `/dev/` directory. At this stage, you are not able to use this device as the USB filesystem needs to be mounted before you can retrieve or store any data. To find out what name your block device file have you can run `fdisk -l `command.

```shell
lsusb
sudo fdisk -l
```
```shell
$ lsusb
	Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 003 Device 002: ID 20f4:804b TRENDnet
	Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 002: ID 046d:c06a Logitech, Inc. USB Optical Mouse
	Bus 001 Device 003: ID 0951:1624 Kingston Technology DataTraveler G2
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

Upon executing the above command you will get an output similar to the one below:
```shell        
$ sudo fdisk -l
	...    
	Disk /dev/sdb: 4001 MB, 4001366016 bytes
	255 heads, 63 sectors/track, 486 cylinders, total 7815168 sectors
	Units = sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disk identifier: 0x236421af
	Device Boot      Start         End      Blocks   Id  System
	/dev/sdb1   *         128     7815167     3907520    c  W95 FAT32 (LBA)
```
The above output will most likely list multiple disks attached to your system. Look for your USB drive based on its size and filesystem. Once ready, take a note of the block device name of the partition you intent to mount. For example in our case that will be `/dev/sdb1` with FAT32 filesystem.

### 2. Create a custom mount point
Before we are able to use mount command to mount the USB partition, we need to create a mount point. Mount point can be any new or existing directory within your host filesystem. Use mkdir command to create a new mount point directory where you want to mount your USB device:
```shell
sudo mkdir /media/usb-drive   or
sudo mkdir /tmp/usb    ....
```

### 3. Mount USB in Linux
At this stage we are ready to mount USB partition /dev/sdb1 into `/media/usb-drive` or `/tmp/usb` mount point:

```shell
sudo mount /dev/sdb1 /media/usb-drive/   or
sudo mount /dev/sdb1 /tmp/usb/
```

### 4. Accessing USB Data
If all went well, we can access our USB data simply by navigating to our previously created mount point /media/usb-drive:
```shell
ls /media/usb-drive   or
ls /tmp/usb
```

### 5. USB Unmount
Before we are able to unmount our USB partition we need to make sure that no process is using or accessing our mount point directory, otherwise we will receive an error message similar to the one below:
`umount: /media/usb-drive: target is busy`
(In some cases useful info about processes that
use the device is found by lsof(8) or fuser(1).)
Close your shell or navigate away from USB mount point and execute the following linux command to unmount your USB drive:

```shell
cd /
sudo umount /media/usb-drive  or
sudo umount /tmp/usb
```