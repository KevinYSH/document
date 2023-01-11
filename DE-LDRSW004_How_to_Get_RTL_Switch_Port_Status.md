**No:DE-LDRSW004 2019-12-13 **
# How to Get RTL Switch Port Status
## Key Word:
Switch API, MDC, MDIO, SMI, Port, status, PHY, MAC
## Description

1. For confirming the port link status, you need to use the API function to get the port information.

2. call function below,

a. Check the Ext. Port set 
`rtk_port_macForceLinkExt_get(rtk_port_t port, rtk_mode_ext_t mode, rtk_port_mac_ability_t *pPortability);`

b. 



## Directions
example:
```cpp
rtk_api_ret_t retVal;
// read External port seting
// call rtk_port_macForceLinkExt_get();
if ((retVal = rtk_port_macForceLinkExt_get(EXT_PORT0, &pMode, &pPortability) == RT_ERR_OK) {
    printf(Port %d , "Mode %d \n", port,pMode);
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

// read LAN port Link status
rtk_port_phyStatus_get(rtk_port_t port, rtk_port_linkStatus_t *pLinkStatus, rtk_port_speed_t *pSpeed, rtk_port_duplex_t *pDuplex)
ex:  rtk_port_phyStatus_get(UTP_PORT0, pLinkStatus, pSpeed, pDuplex);

這個可以讀取目前Ext port 的連線狀態(RGMII)
rtk_port_macStatus_get(rtk_port_t port, rtk_port_mac_ability_t *pPortstatus)
ex:  rtk_port_macStatus_get(EXT_PORT0, pPortstatus);


rtk_port_macForceLinkExt_get(rtk_port_t port, rtk_mode_ext_t mode, rtk_port_mac_ability_t *pPortability);

// read mib counter per-Port
rtk_stat_port_getAll(UTP_PORT0, &port_cntrs);
display_port_stat(portNum, &port_cntrs);

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