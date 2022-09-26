**No:DE-LDRSW007 2022-09-26 **
# How to set RTL Switch Port Force Link
## Key Word:
Switch API, MDC, MDIO, SMI, register, Force Link
## Description
1. Set switch forced link per-port.
2. Do not use 1G or other speeds.

## Directions
Use function `rtk_port_phyAutoNegoAbility_set()` in API .

for exapmle:
Disable 1G link, use speed with 10/100M.
```cpp
rtk_port_phy_ability_t ability;

ability. AutoNegotiation = 1;
ability. Half_10= 1;
ability. Full_10= 1;
ability. Half_100= 1;
ability. Full_100= 1;
ability. Full_1000= 0;
ability. FC= 1;
ability. AsyFC= 1;

rtk_port_phyAutoNegoAbility_set(UTP_PORT1, &ability);

```
