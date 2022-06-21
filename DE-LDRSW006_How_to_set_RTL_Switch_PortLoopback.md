** No:DE-LD*RSW006 2022-06-21
# How to set RTL Switch Port Loopback
## Key Word:
Switch API, MDC, MDIO, SMI, register, loopback
## Description
Set up switch port loopback by setting port registers to test performance.
## Directions

1. set loopback port register `Reg 0x08b4`

| bit   | Description (5 port) | | bit   | Description (8 port) |
| :---: | :----------- | -- | :----: | :----------- |
| 15..8 | Reserved     |    | 15..11 | Reserved     |
| 7..6  | EXT_Port 1,0 |    | 10..8  | EXT_Port 2-0 |
| 4..0  | UTP_Port 4-0 |    | 7..0   | UTP_Port 7-0 |

2. Set the Traffic through root
`Reg 0x08b5` ~ `Reg 0x08bf `is per-port setting the traffic through.

| Register    | Description (5 port)| | Register    | Description (8 port) |
| :---------: | :---------- | -- | :---------: | :---------- |
| 0x8bc-0x8bb | EXT_port1,0 |    | 0x8bf-0x8bd | EXT_port2-0 |
| 0x8b9-0x8b5 | UTP_Port4-0 |    | 0x8bc-0x8b5 | UTP_Port7-0 |

|   bit   | Description(5 port) | |   bit   | Description(8 port)|
| :-----: | :----------- | -- | :-----: | :----------- |
| 15..8   | Reserved     |    | 15..11  | Reserved     |
| 7..6    | EXT_Port 1,0 |    | 10..8   | EXT_Port 1,0 |
| 4..0    | UTP_Port 4-0 |    | 7..0    | UTP_Port 4-0 |

for exapmle:
ex1:
if set the EXT_port0 loopback of Realtek 8 port switch

```cpp
rtl8367c_setAsicReg(0x8b4, 0x0100);
rtl8367c_setAsicReg(0x8bd, 0x0100);
```
ex2:
if set the EXT_port1 loopback of Realtek 5 port switch
```cpp
rtl8367c_setAsicReg(0x8b4, 0x0080);
rtl8367c_setAsicReg(0x8bc, 0x0080);
```
ex3:
if set the UTP_port4 loopback of Realtek 8 port switch
```cpp
rtl8367c_setAsicReg(0x8b4, 0x0010);
rtl8367c_setAsicReg(0x8b9, 0x0010);
```

