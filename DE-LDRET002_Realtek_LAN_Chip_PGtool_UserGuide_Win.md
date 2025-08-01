**No:DE-LDKET002_Realtek_LAN_Chip_PGtool_UserGuide_Win 2024-02-06**
# Realtek LAN Chip PGtool UserGuide Win
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
#### 1. Set the CFG file corresponding to the Chip
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
#### 2. Use command line to stop the Realtek driver from working.
Use Administrator to open Windows command line applications.
```shell
C:\> SET HWID= "PCI\VEN_10EC&DEV_8131" "PCI\VEN_10EC&DEV_8136" "PCI\VEN_10EC&DEV_8137" "PCI\VEN_10EC&DEV_8168" "PCI\VEN_10EC&DEV_8161" "PCI\VEN_10EC&DEV_8169" "PCI\VEN_10EC&DEV_8167" "PCI\VEN_10EC&DEV_8125" "PCI\VEN_10EC&DEV_2502" "PCI\VEN_10EC&DEV_2600" "PCI\VEN_10EC&DEV_3000" "PCI\VEN_10EC&DEV_8162"

C:\> net stop DashClientService
C:\> devcon64.exe disable %HWID%
```
Now, PGtool is available for operation
#### 3. Check if the PGtool can read the chip
```shell
C:\> RTNicPgW64.exe /efuse /r  # use efuse
C:\> RTNicPgW64.exe /eeprom /r # use eeprom

# If you use more than two identical ICs, you need to add " /# <Number> "
C:\> RTNicPgW64.exe /efuse /r /# 1     # read first chip
C:\> RTNicPgW64.exe /efuse /r /# 2     # read scend chip
```
#### 4. Programming the chip
* Single chip
```shell
C:\> RTNicPgW64.exe /efuse   # Write the data in the CFG file to the chip.
C:\> RTNicPgW64.exe /efuse /r   # Read and check whether it is correct
```
* Mutibale chip
```shell
# Write the data in the CFG file to the chip, and SN will automatically increase by 1.
C:\> RTNicPgW64.exe /efuse /cfgsnchg /# 1 
C:\> RTNicPgW64.exe /efuse /cfgsnchg /# 2
C:\> RTNicPgW64.exe /efuse /cfgsnchg /# 3

# Read and check whether it is correct
C:\> RTNicPgW64.exe /efuse /r /# 1
C:\> RTNicPgW64.exe /efuse /r /# 2
C:\> RTNicPgW64.exe /efuse /r /# 3
```
<font color="#FF0000">*** Please do not program efuse multiple times. If 256 bytes are used up, the IC must be replaced with a new one. ***</font>

#### 5. Modify individual parameters
* Modify MAC Address
```shell
# command RTNicPgW64.exe /efuse /nodeid HexNODEID
C:\> RTNicPgW64.exe /efuse /nodeid 112233445566
# Mutibale chip
C:\> RTNicPgW64.exe /efuse /# 1 /nodeid  ffeeddccbbaa 
C:\> RTNicPgW64.exe /efuse /# 2 /nodeid  ffeeddccbbab
C:\> RTNicPgW64.exe /efuse /# 3 /nodeid  ffeeddccbbac 
```

* Modify SVID/SMID
```shell
# command  RTNicPgX64.efi /efuse /svid HexSVID HexSMID
C:\> RTNicPgW64.exe /efuse /svid 10EC 8168
# Mutibale chip
C:\> RTNicPgW64.exe /efuse /# 1 /svid 10EC 8168
C:\> RTNicPgW64.exe /efuse /# 2 /svid 10EC 8168
C:\> RTNicPgW64.exe /efuse /# 3 /svid 10EC 8168
```

* Modify LED setting
write register.
```shell
### for the 1G Lan LED config
# exmple 
# LEDCFG = High-Byte(19H) Low-Byte(18H)
# LEDCFG = 04 28 (exp)
C:\> RTNicPgW64.exe /efuse /maciob 18 28   # write Register 18H = 0x28 .
C:\> RTNicPgW64.exe /efuse /maciob 19 04   # write Register 19H = 0x04 .

# Mutibale chip
C:\> RTNicPgW64.exe /efuse /#1 /maciob 18 28
C:\> RTNicPgW64.exe /efuse /#1 /maciob 19 04
C:\> RTNicPgW64.exe /efuse /#2 /maciob 18 28
C:\> RTNicPgW64.exe /efuse /#2 /maciob 19 04
C:\> RTNicPgW64.exe /efuse /#3 /maciob 18 28
C:\> RTNicPgW64.exe /efuse /#3 /maciob 19 04

### for the 2.5G Lan LED config
# exmple 
# LEDxCFG = High-Byte Low-Byte
# LED0CFG = 02 01  (18H)
# LED1CFG = 02 02  (86H)
# LED2CFG = 02 08  (84H)
# LED3CFG = 02 20  (96H)
C:\> RTNicPgW64.exe /efuse /maciob 18 01   # write Register 18H = 0x01 .
C:\> RTNicPgW64.exe /efuse /maciob 19 02   # write Register 19H = 0x02 .
C:\> RTNicPgW64.exe /efuse /maciob 86 02   # write Register 86H = 0x02 .
C:\> RTNicPgW64.exe /efuse /maciob 87 02   # write Register 87H = 0x02 .
C:\> RTNicPgW64.exe /efuse /maciob 84 08   # write Register 84H = 0x08 .
C:\> RTNicPgW64.exe /efuse /maciob 85 02   # write Register 85H = 0x02 .
C:\> RTNicPgW64.exe /efuse /maciob 96 20   # write Register 96H = 0x20 .
C:\> RTNicPgW64.exe /efuse /maciob 97 02   # write Register 97H = 0x02 .


```
<font color="#FF0000">*** Please do not program efuse multiple times. If 256 bytes are used up, the IC must be replaced with a new one. ***</font>
#### 6. Complete PGTool
After completing PGTool, you need to restart the Realtek driver.
type
```shell
C:\> devcon64.exe enable %HWID%
C:\> net start DashClientService
```
