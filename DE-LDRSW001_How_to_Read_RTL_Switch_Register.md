**No:DE-LDRSW001 2022-02-24**
# How to Read/Write RTL Switch register
## Key Word:
Switch API, MDC, MDIO, SMI, register
## Description
1. In order to confirm that the interface action of switch is normal, it can be realized by read/write `smi_read()` / `smi_write()` or `rtl8367c_getAsicReg`/`rtl8367c_setAsicReg`
2. To reading the register of the port by use Read/Write `rtl8367c_getAsicPHYReg()` / `rtl8367c_setAsicPHYReg()`

## Directions
**1.R/W register**

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

**2.R/W register by port**

example:

```cpp
/* Read register of Port_0 Reg=1 port status. */
rtl8367c_getAsicPHYReg(UTP_PORT0,0x1, &regData ); // Read Port0 status register.

/* Reset Port1 */
rtl8367c_setAsicPHYReg(UTP_PORT1,0x0, 0x0800 ); // Port Link down
rtl8367c_setAsicPHYReg(UTP_PORT1,0x0, 0x9200 ); // Port Link Up
```

**3.chip reset**

example:

```cpp
/* reset chip */
rtl8367c_setAsicRegBits(RTL8367C_REG_CHIP_RESET,RTL8367C_CHIP_RST_MASK,1);
// or
rtl8367c_setAsicReg(RTL8367C_REG_CHIP_RESET, 0x1);

/* After reset switch must re-init. */

```

**4. Get Chip ID**
example:

```cpp
/* get chip ID */
static int get_chip_id()
{
    rtk_uint32 data, regValue;
    rtl8367c_setAsicReg(0x13C2, 0x0249)
    rtl8367c_getAsicReg(0x1300, &data);
    rtl8367c_getAsicReg(0x1301, &regValue);
    rtl8367c_setAsicReg(0x13C2, 0x0000);
    switch (data)
    {
        case 0x0276:
        case 0x0597:
        case 0x6367:
            printf("Chip is RTL8367x ; id=0x%4.4x \n", data );
            break;
        case 0x0652:
        case 0x6368:
            printf("Chip is RTL8370Mx ; id=0x%4.4x \n", data );
            break;
        case 0x0801:
        case 0x6511:
            if( (regValue & 0x00F0) == 0x0080)
            {
                printf("Chip is RTL8363SC ; id=0x%4.4x \n", data );
            } 
            else 
            {
                printf("Chip is RTL8364NB ; id=0x%4.4x \n", data );
            }
            break;
        default:
            printf("not Chip ID !! id=0x%4.4x \n", data );
            return -1 ;
    }
}
```