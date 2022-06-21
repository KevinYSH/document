**No:DE-LDRSW003 2019-12-13
# How to Use RTL Switch SGMII interface
## Key Word:
Switch API, MDC, MDIO, SMI, SGMII
## Description

1. To use the SGMII interface with Realtek LAN Switch, need to use the
API code and porting to the system SDK.

## Directions
example:
```cpp
rtk_switch_init();
rtk_port_mac_ability_t mac_cfg ;
rtk_mode_ext_t mode ;
mode = MODE_EXT_SGMII ;
mac_cfg.forcemode = MAC_FORCE ;
mac_cfg.speed = PORT_SPD_1000M;
mac_cfg.duplex = PORT_FULL_DUPLEX;
mac_cfg.link = PORT_LINKUP;
mac_cfg.nway = DISABLED;
mac_cfg.txpause = ENABLED;
mac_cfg.rxpause = ENABLED;
rtk_port_macForceLinkExt_set(EXT_PORT0,mode,&mac_cfg);
rtk_port_macForceLinkExt_set(EXT_PORT1,mode,&mac_cfg);
rtk_port_phyEnableAll_set(ENABLED);
rtk_port_sds_reset();
```

###### external port index tabel
| index  | Mode  | index  | Mode |
|:--:| ------------------ |:---:| -------------------- |
| 0  | MODE_EXT_DISABLE   |  7  | MODE_EXT_RMII_MAC    |
| 1  | MODE_EXT_RGMII     |  8  | MODE_EXT_RMII_PHY    |
| 2  | MODE_EXT_MII_MAC   |  9  | MODE_EXT_SGMII       |
| 3  | MODE_EXT_MII_PHY   | 10  | MODE_EXT_HSGMII      |
| 4  | MODE_EXT_TMII_MAC  | 11  | MODE_EXT_1000X_100FX |
| 5  | MODE_EXT_TMII_PHY  | 12  | MODE_EXT_1000X       |
| 6  | MODE_EXT_GMII      | 13  | MODE_EXT_100FX       |


