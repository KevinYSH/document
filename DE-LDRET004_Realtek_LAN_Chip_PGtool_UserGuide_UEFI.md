**No:DE-LDKET004_Realtek_LAN_Chip_PGtool_UserGuide_UEFI 2025-02-27**
# Realtek LAN Chip PGtool UserGuide UEFI
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
This PGTOOL needs to be operated in the UEFI shell environment, and make sure that UEFI has the driver.
The corresponding driver can be downloaded from Realtek official website.

#### 1. Load the ship driver

```shell
# for the example use fs0 disk.
# load nic driver
fs0>load rtkundidxe.efi

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
Rtnicpgx64.efi  /efuse /r  # use efuse
Rtnicpgx64.efi  /eeprom /r # use eeprom

# If you use more than two identical ICs, you need to add " /# <Number> "
Rtnicpgx64.efi  /efuse /r /# 1     # read first chip
Rtnicpgx64.efi  /efuse /r /# 2     # read scend chip
```

#### 4. Programming the chip
* Single chip
```shell
Rtnicpgx64.efi  /efuse        # Write the data in the CFG file to the chip.
Rtnicpgx64.efi  /efuse /r     # Read and check whether it is correct
```
* Mutibale chip
```shell
# Write the data in the CFG file to the chip, and SN will automatically increase by 1.
Rtnicpgx64.efi  /efuse /efwsn /cfgsnchg /# 1 
Rtnicpgx64.efi  /efuse /efwsn /cfgsnchg /# 2
Rtnicpgx64.efi  /efuse /efwsn /cfgsnchg /# 3

# Read and check whether it is correct
Rtnicpgx64.efi  /efuse /r /# 1
Rtnicpgx64.efi  /efuse /r /# 2
Rtnicpgx64.efi  /efuse /r /# 3
```
<font color="#FF0000">*** Please do not program efuse multiple times. If 256 bytes are used up, the IC must be replaced with a new one. ***</font>

#### 5. Modify individual parameters

* Modify MAC Address
```shell
# command RTNicPgX64.efi /efuse /nodeid HexNODEID
Rtnicpgx64.efi  /efuse /nodeid 112233445566
# Mutibale chip
Rtnicpgx64.efi  /efuse /# 1 /nodeid  ffeeddccbbaa 
Rtnicpgx64.efi  /efuse /# 2 /nodeid  ffeeddccbbab
Rtnicpgx64.efi  /efuse /# 3 /nodeid  ffeeddccbbac 
```

* Modify SVID/SMID
```shell
# command  RTNicPgX64.efi /efuse /svid HexSVID HexSMID
Rtnicpgx64.efi  /efuse /svid 10EC 8168
# Mutibale chip
Rtnicpgx64.efi  /efuse /# 1 /svid 10EC 8168
Rtnicpgx64.efi  /efuse /# 2 /svid 10EC 8168
Rtnicpgx64.efi  /efuse /# 3 /svid 10EC 8168
```

* Modify LED setting
write register.
```shell
### for the 1G Lan LED config
# exmple 
# LEDCFG = High-Byte(19H) Low-Byte(18H)
# LEDCFG = 04 28 (exp)
Rtnicpgx64.efi  /efuse /maciob 18 28   # write Register 18H = 0x28 .
Rtnicpgx64.efi  /efuse /maciob 19 04   # write Register 19H = 0x04 .

# Mutibale chip
Rtnicpgx64.efi  /efuse /#1 /maciob 18 28
Rtnicpgx64.efi  /efuse /#1 /maciob 19 04
Rtnicpgx64.efi  /efuse /#2 /maciob 18 28
Rtnicpgx64.efi  /efuse /#2 /maciob 19 04
Rtnicpgx64.efi  /efuse /#3 /maciob 18 28
Rtnicpgx64.efi  /efuse /#3 /maciob 19 04

### for the 2.5G Lan LED config
# exmple 
# LEDxCFG = High-Byte Low-Byte
# LED0CFG = 02 01  (18H)
# LED1CFG = 02 02  (86H)
# LED2CFG = 02 08  (84H)
# LED3CFG = 02 20  (96H)
Rtnicpgx64.efi  /efuse /maciob 18 01   # write Register 18H = 0x01 .
Rtnicpgx64.efi  /efuse /maciob 19 02   # write Register 19H = 0x02 .
Rtnicpgx64.efi  /efuse /maciob 86 02   # write Register 86H = 0x02 .
Rtnicpgx64.efi  /efuse /maciob 87 02   # write Register 87H = 0x02 .
Rtnicpgx64.efi  /efuse /maciob 84 08   # write Register 84H = 0x08 .
Rtnicpgx64.efi  /efuse /maciob 85 02   # write Register 85H = 0x02 .
Rtnicpgx64.efi  /efuse /maciob 96 20   # write Register 96H = 0x20 .
Rtnicpgx64.efi  /efuse /maciob 97 02   # write Register 97H = 0x02 .
```
<font color="#FF0000">*** Please do not program efuse multiple times. If 256 bytes are used up, the IC must be replaced with a new one. ***</font>
#### 6. Complete PGTool
```shell
# Unload the driver of pgtool when programming is done.
rmmod pgdrv
reboot
```

## Note: 
Some UEFI versions do not support the `/#` command.
If multiple CHIPs need to be Programming,
you need to change `/#` to `/^#` to use it normally.
