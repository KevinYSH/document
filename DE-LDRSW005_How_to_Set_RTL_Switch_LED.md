**No:DE-LDRSW005 2022-03-21**
# How to Set RTL Switch LED
## Key Word:
Switch API, MDC, MDIO, SMI, register, LED
## Description
Example of setting LED display enable and behavior.

## Directions

example:
```cpp
rtk_switch_init();
//...
uint32 regValue;

/*Set LED mode group 0 ~ 2 to LED_CONFIG_LINK_ACT,LED_CONFIG_SPD100,LED_CONFIG_SPD1000 */
rtk_led_groupConfig_set(LED_GROUP_0, LED_CONFIG_LINK_ACT);
rtk_led_groupConfig_set(LED_GROUP_1, LED_CONFIG_SPD100);
rtk_led_groupConfig_set(LED_GROUP_2, LED_CONFIG_SPD1000);

/*The hardware layout only use group 0 & group 1 & group 2, and the port is Port 0 ~ Port 4 */
rtk_portmask_t portmask;
RTK_PORTMASK_PORT_SET(portmask, UTP_PORT0);
RTK_PORTMASK_PORT_SET(portmask, UTP_PORT1);
RTK_PORTMASK_PORT_SET(portmask, UTP_PORT2);
RTK_PORTMASK_PORT_SET(portmask, UTP_PORT3);
RTK_PORTMASK_PORT_SET(portmask, UTP_PORT4);
rtk_led_enable_set(LED_GROUP_0, &portmask);
rtk_led_enable_set(LED_GROUP_1, &portmask);
rtk_led_enable_set(LED_GROUP_2, &portmask);

rtk_led_OutputEnable_set(ENABLED);

#if DEFIND_LED_PARALLEL  
  rtk_led_operation_set(LED_OP_PARALLEL); // use the switch internal LED pin out.
#else
  rtk_led_operation_set(LED_OP_SERIAL); // use the RTL8370MB serial mode
  /* optional function */
  rtk_led_serialModePortmask_set(SERIAL_LED_0_2,&portmask); //LED group output LED0,LED1,LED2
  rtk_led_serialMode_set(LED_ACTIVE_HIGH);
  /* for RTL8370MB need to set. */
  
  rtl8367c_getAsicReg(0x1b3a, &regValue); 
  rtl8367c_setAsicReg(0x1b3a, regValue); 
  
  // note:
  /* 0x1b3a defind. */
  /* bit[14:13]	 fg_serial_led_shift_sequence */
  /*serial LED shift sequence */
  /* 00: High port LED0--->Low  Port LED0->High port LED1--->Low  port LED1->High port LED2--->Low  port LED2 */
  /*         (P8LED0)  --->    (P0LED0)  ->    (P8LED1)  --->    (P0LED1)  ->    (P8LED2)  --->    (P0LED2)   */
  /* 01: High port LED0  ->High Port LED1->High port LED2--->Low  port LED0->Low  port LED1  ->Low  port LED2 */
  /*         (P8LED0)    ->    (P8LED1)  ->    (P8LED2)  --->    (P0LED0)  ->    (P0LED1)    ->    (P0LED2)   */
  /* 10: Low  port LED0  ->Low  port LED1->Low  port LED2--->High port LED0->High port LED1  ->High port LED2 */
  /*         (P0LED0)    ->    (P0LED1)  ->    (P0LED2)  --->    (P8LED0)  ->    (P8LED1)    ->    (P8LED2)   */
  /* 11: Low  port LED0--->High port LED0->Low  port LED1--->High port LED1->Low  port LED2--->High port LED2 */
  /*         (P0LED0)  --->    (P8LED0)  ->    (P0LED1)  --->    (P8LED1)  ->    (P0LED2)  --->    (P8LED2)   */
  /* bit[11:10] : LED group number, 00=LED off ; 01=LED0 ;10=LED0,LED1 ;11=LED0,LED1,LED2
  /* bit[9:0]   : LED Output port select, port 7 to 0 enable =0x0ff */
#endif

//...
rtk_port_phyEnableAll_set(ENABLED);
```

###### LED behavior select tabel
| LED Mode  |
|:--| 
| LED_CONFIG_LEDOFF      |
| LED_CONFIG_LINK_ACT    |
| LED_CONFIG_SPD1000     |
| LED_CONFIG_SPD100      |
| LED_CONFIG_SPD10       |
| LED_CONFIG_SPD1000ACT  |
| LED_CONFIG_SPD100ACT   |
| LED_CONFIG_SPD10ACT    |
| LED_CONFIG_SPD10010ACT |
| LED_CONFIG_ACT         |
