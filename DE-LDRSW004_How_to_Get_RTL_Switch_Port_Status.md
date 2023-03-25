**No:DE-LDRSW004 2019-12-13**
# How to Get RTL Switch Port Status
## Key Word:
Switch API, MDC, MDIO, SMI, Port, status, PHY, MAC, mib counter
## Description

1. For confirming the port link status, you need to use the API function to get the port information.

2. call function below,

    a. Check the Ext. Port set 
    `rtk_port_macForceLinkExt_get()`

    b. Read UTP port link status
    `rtk_port_phyStatus_get()`
    
    c. Read External port link status (RGMII , SGMII ...)
    `rtk_port_macStatus_get()`
    
    d. read mib counter per-Port
    `rtk_stat_port_getAll()`
    
## Directions
example:
```cpp
void mail()
{
    ...
    
    rtk_api_ret_t retVal;
    // read External port seting
    // call rtk_port_macForceLinkExt_get();
    port="EXT_PORT0";
    if ((retVal = rtk_port_macForceLinkExt_get(port, &pMode, &pPortability) == RT_ERR_OK) {
        printf("Port %d , Mode %d \n", port,pMode);
        if (pPortability.link == 0) {
             printf( "LinkDown \n");
        }
        else {
            printf( "LinkUp \n");
        }
        
        printf( "NWay Mode %s\n", (pPortability.nway) ?"Enabled":"Disabled");
        printf( "RXPause %s | ", (pPortability.rxpause) ?"Enabled":"Disabled");
        printf( "TXPause %s\n", (pPortability.txpause) ?"Enabled":"Disabled");
        printf( "Duplex %s | ", (pPortability.duplex) ?"Enabled":"Disabled");
        printf( "Speed %s\n\n", (pPortability.speed) ==PortStatusLinkSpeed100M?"100M":
                                ((pPortability.speed) ==PortStatusLinkSpeed1000M?"1G":
                                ((pPortability.speed) ==PortStatusLinkSpeed10M?"10M":"Unkown")));
    esle {
        printf( "Error: rtk_port_macForceLinkExt_get() retVAL=%d \n" ,retVAL);
        }
    }

    // read MAC port Link status (RGMII)
    // rtk_port_macStatus_get(rtk_port_t port, rtk_port_mac_ability_t *pPortstatus)
    port="EXT_PORT0";
    if ((retVal = rtk_port_macStatus_get(port, &pPortstatus)) == 0) {
        printf("Port %d ", port);
        if (sts.link == 0) {
             printf( "LinkDown\n");
        }
        else {
            printf( "LinkUp \n ");
        }
        printf( " NWay Mode %s\n", (pPortstatus.nway) ?"Enabled":"Disabled");
        printf( " RXPause %s | ", (pPortstatus.rxpause) ?"Enabled":"Disabled");
        printf( " TXPause %s\n", (pPortstatus.txpause) ?"Enabled":"Disabled");
        printf( " Duplex %s | ", (pPortstatus.duplex) ?"Enabled":"Disabled");
        printf( " Speed %s\n\n", (pPortstatus.speed) ==PortStatusLinkSpeed100M?"100M":
                                ((pPortstatus.speed) ==PortStatusLinkSpeed1000M?"1G":
                                ((pPortstatus.speed) ==PortStatusLinkSpeed10M?"10M":"Unkown")));
    }
    else { 
        printf("error: rtk_port_macStatus_get() retVAL=%d \n" ,retVAL);
    }
    
    // read LAN port Link status
    // rtk_port_phyStatus_get(rtk_port_t port, rtk_port_linkStatus_t *pLinkStatus, rtk_port_speed_t *pSpeed, rtk_port_duplex_t *pDuplex)
    port="UTP_PORT0";
    if ((retVal = rtk_port_phyStatus_get(port, &pLinkStatus, &pSpeed, &pDuplex)) == 0) {
        printf("Port %d , \n", port);
    
        if (pLinkStatus == 0) {
            printf( " LinkDown\n");
        }
        else {
            printf( " LinkUp \n");                                
            printf( " Duplex = %s | ", pDuplex?"Full":"Half");
            printf( " Speed %s\n\n", pSpeed==PortStatusLinkSpeed100M?"100M":
                          (pSpeed==PortStatusLinkSpeed1000M?"1G":
                          (pSpeed==PortStatusLinkSpeed10M?"10M":"Unkown")));
        }
    }
    else { 
        printf("error: rtk_port_phyStatus_get() retVAL=%d \n" ,retVAL);
    }

    // read mib counter per-Port
    rtk_stat_port_getAll(port, &port_cntrs);
    display_port_stat(port, &port_cntrs);

    ...
}

void display_port_stat(uint32 port, rtk_stat_port_cntr_t *pPort_cntrs)
{
    printf("\n<Port: %d>\n", port);
    printf("Rx counters\n");

    printf("   ifInOctets  %llu\n", pPort_cntrs->ifInOctets);
    printf("   etherStatsOctets  %llu\n", pPort_cntrs->etherStatsOctets);
    printf("   ifInUcastPkts  %u\n", pPort_cntrs->ifInUcastPkts);
    printf("   etherStatsMcastPkts  %u\n", pPort_cntrs->etherStatsMcastPkts);
    printf("   etherStatsBcastPkts  %u\n", pPort_cntrs->etherStatsBcastPkts);

    printf("   StatsFCSErrors  %u\n", pPort_cntrs->dot3StatsFCSErrors);
    printf("   StatsSymbolErrors  %u\n", pPort_cntrs->dot3StatsSymbolErrors);
    printf("   InPauseFrames  %u\n", pPort_cntrs->dot3InPauseFrames);
    printf("   ControlInUnknownOpcodes  %u\n", pPort_cntrs->dot3ControlInUnknownOpcodes);
    printf("   etherStatsFragments  %u\n", pPort_cntrs->etherStatsFragments);
    printf("   etherStatsJabbers  %u\n", pPort_cntrs->etherStatsJabbers);
    printf("   etherStatsDropEvents  %u\n", pPort_cntrs->etherStatsDropEvents);

    printf("   etherStatsUndersizePkts  %u\n", pPort_cntrs->etherStatsUndersizePkts);
    printf("   etherStatsOversizePkts  %u\n", pPort_cntrs->etherStatsOversizePkts);

    printf("   dot1dTpPortInDiscards  %u\n", pPort_cntrs->dot1dTpPortInDiscards);
    printf("   inOampduPkts  %u\n", pPort_cntrs->inOampduPkts);

    printf("   Len= 64: %u pkts, 65 - 127: %u pkts, 128 - 255: %u pkts\n",
        pPort_cntrs->etherStatsPkts64Octets,
        pPort_cntrs->etherStatsPkts65to127Octets,
        pPort_cntrs->etherStatsPkts128to255Octets);
    printf("       256 - 511: %u pkts, 512 - 1023: %u pkts, 1024 - 1518: %u pkts\n",
        pPort_cntrs->etherStatsPkts256to511Octets,
        pPort_cntrs->etherStatsPkts512to1023Octets,
        pPort_cntrs->etherStatsPkts1024toMaxOctets);

    printf("\nOutput counters\n");

    printf("   ifOutOctets  %llu\n", pPort_cntrs->ifOutOctets);
    printf("   ifOutUcastPkts  %u\n", pPort_cntrs->ifOutUcastPkts);
    printf("   ifOutMulticastPkts  %u\n", pPort_cntrs->ifOutMulticastPkts);
    printf("   ifOutBrocastPkts  %u\n", pPort_cntrs->ifOutBrocastPkts);
    printf("   ifOutDiscards  %u\n", pPort_cntrs->ifOutDiscards);
    printf("   StatsSingleCollisionFrames  %u\n", pPort_cntrs->dot3StatsSingleCollisionFrames);
    printf("   StatsMultipleCollisionFrames  %u\n", pPort_cntrs->dot3StatsMultipleCollisionFrames);
    printf("   StatsDeferredTransmissions  %u\n", pPort_cntrs->dot3StatsDeferredTransmissions);
    printf("   StatsLateCollisions  %u\n", pPort_cntrs->dot3StatsLateCollisions);
    printf("   etherStatsCollisions  %u\n", pPort_cntrs->etherStatsCollisions);
    printf("   StatsExcessiveCollisions  %u\n", pPort_cntrs->dot3StatsExcessiveCollisions);
    printf("   OutPauseFrames  %u\n", pPort_cntrs->dot3OutPauseFrames);
    printf("   dot1dBasePortDelayExceededDiscards  %u\n", pPort_cntrs->dot1dBasePortDelayExceededDiscards);

    printf("   outOampduPkts  %u\n", pPort_cntrs->outOampduPkts);
    printf("   pktgenPkts  %u\n", pPort_cntrs->pktgenPkts);
}
```
