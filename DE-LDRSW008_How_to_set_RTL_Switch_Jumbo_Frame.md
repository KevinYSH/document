**No:DE-LDRSW00 2023-01-10**
# How to set RTL Switch Jumbo Frame
## Key Word:
Switch API, MDC, MDIO, SMI, register, Jumbo Frame
## Description
1. Set switch Jumbo Frame.

## Directions
Use 2 functions in API .

1. `rtk_switch_maxPktLenCfg_set(rtk_uint32 cfgId, rtk_uint32 pktLen);`

2. `rtk_switch_portMaxPktLen_set(rtk_port_t port, rtk_switch_maxPktLen_linkSpeed_t speed, rtk_uint32 cfgId);`

`cfgId` The realtek switch can support 2 groups of Jumbo Frame settings, use (0 and 1)

`pktLen` can be set up to a maximum length of 16K()

for exapmle:

Set Port 1 Jumbo Frame = 9000

```cpp
rtk_switch_maxPktLenCfg_set(1, 9000);
rtk_switch_portMaxPktLen_set(UTP_PORT0,MAXPKTLEN_LINK_SPEED_GE, 1);

```
