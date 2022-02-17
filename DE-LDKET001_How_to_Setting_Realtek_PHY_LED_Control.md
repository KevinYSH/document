** No:DE-LDKET001 2020-02-04 **

# How to Setting Realtek PHY LED Control 
## Key Word:
Linux ; Realtek PHY ; RTL8211 ; LED ;
## Description
To use the Rrealtek Ethernet PHY to set the LED configuration in the system,you need to modify the file of stmmac_mdio.c .
The stmmac_mdio.c path is ./kernel/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
## Directions
1. Need to disable eee LED function and set LED configuration
2. To add config code for example use RTL8211E
##### function
	a. define function
```cpp
// external PHY LED Control add.
static int phy_disable_eee_LED(struct phy_device *phydev);
static int phy_rtl8211e_led_fixup(struct phy_device *phydev);
```

	b. add in stmmac_dvr_probe() function
```cpp
    ret = phy_register_fixup_for_uid(RTL_8211E_PHY_ID, 0xffffffff, phy_disable_eee_LED);
    if (ret)
        pr_warn("Cannot register PHY board eee LED.\n");
    ret = phy_register_fixup_for_uid(RTL_8211E_PHY_ID, 0xffffffff, phy_rtl8211e_led_fixup);
    if (ret)
        pr_warn("Cannot register PHY board fixup.\n");
```

	c. add function
```cpp
    static int phy_rtl8211e_led_fixup(struct phy_device *phydev)
    {
        pr_info("PHY setting RTL8211 LED function. \n");
        //switch to extension page44
        phy_write(phydev, 31, 0x07);
        mdelay(10);
        phy_write(phydev, 30, 0x2c);
        phy_write(phydev, 26, 0x0040); //set led act
        phy_write(phydev, 28, 0x0042); //set led link
        phy_write(phydev,31,0x00); //switch back to page0
        return 0;
    }

    static int phy_disable_eee_LED(struct phy_device *phydev)
    {
        pr_info("PHY disable RTL8211E EEE LED function. \n");
        phy_write(phydev, 31, 0x5);
        mdelay(10);
        phy_write(phydev, 5, 0x8b82);
        phy_write(phydev, 6, 0x052b);
        phy_write(phydev, 31, 0x0);
        return 0;
    }
```