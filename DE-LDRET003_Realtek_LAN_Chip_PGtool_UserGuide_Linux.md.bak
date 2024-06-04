**No:DE-LDKET003_Realtek_LAN_Chip_PGtool_UserGuide_Linux 2024-04-08**
# Realtek LAN Chip PGtool UserGuide Linux
## Key Word:

Realtek LAN chip eFuse Programming ; PGtool ; 

## Description

Realtek LAN needs to write SVID/SMID, MAC, LED... and other parameters through PGtool.
PGtool support three OS tools for `Windows` , `Linux` , `UEFI`
Is can refer to the following link to operate.
[Windows](./DE-LDRET002_Realtek_LAN_Chip_PGtool_UserGuide_Win.md)
[Linux](./DE-LDRET003_Realtek_LAN_Chip_PGtool_UserGuide_Linux.md)
[UEFI](./DE-LDRET004_Realtek_LAN_Chip_PGtool_UserGuide_UEFI.md)

## Operate
The PG tool has its own driver (pdgrv.ko) and it conflicts with the Ethernet driver (r8168/r8169/r8101/r8125/r8126).
That is, the Ethernet driver must not be build-in for kernel image. 
You should remove the Ethernet driver or build it as a module to make it possible to unload the Ethernet driver. 
Besides, the PG tool should be run as `root`, 
otherwise it would fail.

#### 1. Build and Load the PG tool driver
unzip Linux PG tool package by command `tar -jxvpf filename`.
```shell
# run at "root" 
# Step 1: Unload all the Ethernet driver for Realtek.
rmmod r8169
rmmod r8168
rmmod r8125
rmmod r8101

# Step 2: Build the pgdrv.ko and install it.
make clean all
insmod pgdrv.ko

# Step 3: Run the pgtool "rtnicpg". Use /h to show user guide.
./rtnicpg /h | more

```

#### 2. Set the CFG file corresponding to the Chip
##### 1G LAN
RTL8111G(S) -> 8168GEF.CFG ; 
RTL8111H(S) -> 8168HEF.CFG ; 
RTL8119I -> 8119EF.CFG ; 
RTL8111K -> 8168KEF.CFG ; 
##### 2.5G LAN
RTL8125B(S) -> 8125BEF.CFG ; 
RTL8125BG(S) -> 8125BGEF.CFG ; 
##### 5G LAN
RTL8126 -> 8126EF.CFG ; 

#### 3. Check if the PGtool can read the chip
```shell
./rtnicpg /efuse /r  # use efuse
./rtnicpg /eeprom /r # use eeprom

# If you use more than two identical ICs, you need to add " /# <Number> "
./rtnicpg /efuse /r /# 1     # read first chip
./rtnicpg /efuse /r /# 2     # read scend chip
```

#### 4. Programming the chip
* Single chip
```shell
./rtnicpg /efuse        # Write the data in the CFG file to the chip.
./rtnicpg /efuse /r     # Read and check whether it is correct
```
* Mutibale chip
```shell
# Write the data in the CFG file to the chip, and SN will automatically increase by 1.
./rtnicpg /efuse /efwsn /cfgsnchg /# 1 
./rtnicpg /efuse /efwsn /cfgsnchg /# 2
./rtnicpg /efuse /efwsn /cfgsnchg /# 3

# Read and check whether it is correct
./rtnicpg /efuse /r /# 1
./rtnicpg /efuse /r /# 2
./rtnicpg /efuse /r /# 3
```
<font color="#FF0000">*** Please do not program efuse multiple times. If 256 bytes are used up, the IC must be replaced with a new one. ***</font>

#### 5. Modify individual parameters

* Modify MAC Address
```shell
# command RTNicPgX64.efi /efuse /nodeid HexNODEID
./rtnicpg /efuse /nodeid 112233445566
# Mutibale chip
./rtnicpg /efuse /# 1 /nodeid  ffeeddccbbaa 
./rtnicpg /efuse /# 2 /nodeid  ffeeddccbbab
./rtnicpg /efuse /# 3 /nodeid  ffeeddccbbac 
```

* Modify SVID/SMID
```shell
# command  RTNicPgX64.efi /efuse /svid HexSVID HexSMID
./rtnicpg /efuse /svid 10EC 8168
# Mutibale chip
./rtnicpg /efuse /# 1 /svid 10EC 8168
./rtnicpg /efuse /# 2 /svid 10EC 8168
./rtnicpg /efuse /# 3 /svid 10EC 8168
```

* Modify LED setting
write register.
```shell
# exmple 
# LEDCFG = High-Byte(19H) Low-Byte(18H)
# LEDCFG = 04 28 (exp)
./rtnicpg /efuse /maciob 18 28   # write Register 18H = 0x28 .
./rtnicpg /efuse /maciob 19 04   # write Register 18H = 0x04 .

# Mutibale chip
./rtnicpg /efuse /#1 /maciob 18 28
./rtnicpg /efuse /#1 /maciob 19 04
./rtnicpg /efuse /#2 /maciob 18 28
./rtnicpg /efuse /#2 /maciob 19 04
./rtnicpg /efuse /#3 /maciob 18 28
./rtnicpg /efuse /#3 /maciob 19 04
```
<font color="#FF0000">*** Please do not program efuse multiple times. If 256 bytes are used up, the IC must be replaced with a new one. ***</font>
#### 6. Complete PGTool
```shell
# Unload the driver of pgtool when programming is done.
rmmod pgdrv
reboot
```