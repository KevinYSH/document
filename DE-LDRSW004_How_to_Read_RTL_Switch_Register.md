**No:DE-LDRSW004 2022-02-24**
# How to Read/Write RTL Switch register
## Key Word:
Switch API, MDC, MDIO, SMI, register
## Description
1. In order to confirm that the interface action of switch is normal, it can be realized by read/write `smi_read()` / `smi_write()` or `rtl8367c_getAsicReg`/`rtl8367c_setAsicReg`
2. To reading the register of the port by use Read/Write `rtl8367c_getAsicPHYReg()` / `rtl8367c_setAsicPHYReg()`
## Directions
1. R/W register

example:

```cpp
/* smi R/W */
smi_read(0x1202,*rData); // read register 0x1202 ,default value is 0x88a8
printf("smi_read \n", rData);

smi_write(0x1202, random_valeu_set ); // write a random value to 0x1202
smi_read(0x1202,*rData);
printf("smi_read \n", rData);

/* API R/W */
rtl8367c_getAsicReg(0x1202, &regValue);
printf("reg_read \n", regValue );

rtl8367c_setAsicReg(0x1202, regValue);
rtl8367c_getAsicReg(0x1202, &regValue);
printf("reg_read \n", regValue );

```

2. R/W register by port

example:

```cpp
/* Read register of Port_0 Reg=1 port status. */
smrtl8367c_getAsicPHYReg(UTP_PORT0,0x1, &regData ); // Read Port0 status register.

/* Reset Port1 */
smrtl8367c_setAsicPHYReg(UTP_PORT1,0x0, 0x0800 ); // Port Link down
smrtl8367c_setAsicPHYReg(UTP_PORT1,0x0, 0x9200 ); // Port Link Up
```
