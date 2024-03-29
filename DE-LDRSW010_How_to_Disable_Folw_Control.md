**No:DE-LDRSW010 2024-02-21**
# How to Disable Port Folw Control
## Key Word:
Switch API, MDC, MDIO, SMI, register, Folw Control
## Description
1. When UDP Muticast is sent to a mixed environment of 1G and 100M, it may cause traffic imbalance and affect 1G traffic.
```
[PORT0] <--> [Switch] <--> [Port1] 1G
                      <--> [Port3] 100M
```
![](./DE-LDRSW010_Figure01.png)

## Directions
1. Disable the low speed port flow control.
2. Use function `rtk_port_phyAutoNegoAbility_set()` in API to disable flow control.
```
rtk_port_phyAutoNegoAbility_set(rtk_port_t port, rtk_port_phy_ability_t *pAbility);
pAbility->FC = DISABLED;
pAbility->AsyFC = DISABLED;
```
3. Use function `rtl8367c_setAsicFlowControlQueueEgressEnable()` in API to disable Queue.
rtl8367c_setAsicFlowControlQueueEgressEnable(rtk_uint32 port, rtk_uint32 qid, rtk_uint32 enabled)

for exapmle:
UTP_PORT3 is 100M port
Disable UTP_PORT3 flow control.
```cpp

pAbility->FC = DISABLED;
pAbility->AsyFC = DISABLED;
rtk_port_phyAutoNegoAbility_set(UDP_PORT3, rtk_port_phy_ability_t *pAbility);

rtl8367c_setAsicFlowControlQueueEgressEnable(3, 0, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 1, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 2, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 3, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 4, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 5, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 6, DISABLED);
rtl8367c_setAsicFlowControlQueueEgressEnable(3, 7, DISABLED);

```
