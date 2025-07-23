**No:DE-LDRET001 2025-07-23**
# How to Setting Realtek PHY LED Control
## Key Word:

Linux ; Realtek PHY ; RTL8211 ; LED ;

## Description

To use the realtek Ethernet PHY to set the LED configuration in the system,you need to modify the file of realtek.c . The realtek.c path is

Before kernel 6.13 
`./kernel/drivers/net/phy/realtek.c`

After kernel 6.14
`./kernel/drivers/net/phy/realtek/realtek_main.c` 

or other path. 

## Directions

Need to disable eee LED function and set LED configuration.
Add the LED register setting in finction code.

for example:

##### NXP i.max kernel 4.9.51

`rtl8211f` 

find the function

`static int rtl8211f_config_init(struct phy_device *phydev)`

```c
static int rtl8211f_config_init(struct phy_device *phydev)
{
	...
	/* add led defind code */
	/* Disable EEE LED
	* Reg31 = 0x0D04
	* Reg17 = 0x0000
	* Configruation LED setting.  LED0=link/Act ,LED1=speed_100M, LED2=speed_1000M
	* Reg16 = 0x205b
	* Reg31 = 0x0000
	*/
	phy_write(phydev, RTL8211F_PAGE_SELECT, 0xd04);
	phy_write(phydev, 0x11, 0);
	phy_write(phydev, 0x10, 0x205b);
	phy_write(phydev, RTL8211F_PAGE_SELECT, 0x0);

	return 0;
}
```
------------
`rtl8211e`

add the function with led defind code.

`static int rtl8211e_config_led(struct phy_device *phydev)`

```c
/* add code */
static int rtl8211e_config_led(struct phy_device *phydev)
{
	int ret;
	u16 reg;
	/* Disable EEE LED 
	 * Reg31 = 0x0005
	 * Reg5  = 0x8B82
	 * Reg6  = 0x052B
	 * Reg31 = 0x0000
	 * Configruation LED setting. LED0=link/Act ,LED1=speed_100M, LED2=speed_1000M
	 * Reg31 = 0x0007
	 * Reg30 = 0x002C
	 * Reg26 = 0x0010
	 * Reg28 = 0x0427
	 * Reg31 = 0x0000  
	 */
	phy_write(phydev, 0x1f, 0x5);
	phy_write(phydev, 0x5, 0x8b82);
	phy_write(phydev, 0x6, 0x052b);
	phy_write(phydev, 0x1f, 0x7);
	phy_write(phydev, 0x1a, 0x0010);
	phy_write(phydev, 0x1c, 0x0427);
	phy_write(phydev, 0x1f, 0x0);
	return 0;
}
```
