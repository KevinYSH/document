**No:DE-LDRSW008 2023-05-22**
# How to Read/Write RTL Switch register via MDC/MDIO
## Key Word:
Switch API, MDC, MDIO, SMI, register
## Description
1. In order to use MDIO to read/write switch register

## Directions
**1. MDIO R/W register**
`mdio Read`
write_Reg 0x1F = 0x000E
write_Reg 0x17 = Reg_Add
write_Reg 0x15 = 0x0001
read_Reg  0x19 

`mdio Write`
write_Reg 0x1f = 0x000e
write_Reg 0x17 = Reg_Add
write_Reg 0x18 = Reg_Data 
write_Reg 0x15 = 0x0003

example:
Read/Write Reg 0x1202
```share
# mdio Read  
write_Reg 0x1F = 0x000E
write_Reg 0x17 = 0x1202
write_Reg 0x15 = 0x0001
read_Reg  0x19 

# mdio Write  
write_Reg 0x1f = 0x000e
write_Reg 0x17 = 0x1202
write_Reg 0x18 = Reg_Data 
write_Reg 0x15 = 0x0003
```

**2. MDIO get chip_id**
use uboot mii command (in AST2600/ i.mx serial )
example:
```shell
mii write 0 0x1f 0x000e
mii write 0 0x17 0x13c2  //reg23
mii write 0 0x18 0x0249  //reg24
mii write 0 0x15 0x0003

mii write 0 0x1f 0x000e
mii write 0 0x17 0x1300  //reg23
mii write 0 0x15 0x0001  //reg21
mii read 0 0x19 //25
```