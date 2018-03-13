close all;
clear;
clc;

% sf = sourcefile;
% sf = sourcefile for ncrt;
% po = position;
% zr = zigbee communicatoin range;
% nr = network range;
% wr = wifi communicatoin range;
% zt = zigbee routing table;
% wt = wifi routing table;
% zq = zigbee link quality deploy
% wq = wifi link quality deploy
% zw = zigbee wake duration
% zs = zigbee sleep druatoin
% ww = wifi work duration
% wf = wifi traffic
% mq = mean of link quality;
% sq = std of link quality;
    
[sf, nsf, po, nr, zr, wr, zt, wt, zq, wq, zw, zs, ww, wf, mq, sq] = setparameter(1);

enFdWiFiTraffic = 0;
enFdWiFiDistance = 0;
enFdDutyCycle = 0;
enReliabilityWiFiTraffic = 0;
enReliabilityDutyCycle = 0;
enReliabilityDisseTime = 0;
enThFloodFreq = 0;
enTransmissionHop = 0;
enRdTrHop = 0;
enLargeMeshLQ = 1;
enLargeMeshNm = 0;
enLargeTreeLQ= 0;
enLargeTreeNm = 0;
enRePacketsDutyCycle = 0;
enRePacketsWiFiTraffic = 0;

%% evaluation for small scale: fd vs wifi traffic
if enFdWiFiTraffic == 1
    wf1 = 0.1:0.0625:0.6;
    [eva1, fig1] = eva_small_fd_wifitraffic(sf, nsf, zq, wq, zw, zs, ww, wf1);
end

%% evaluation for small scale: fd vs distance of wifi to wifi
if enFdWiFiDistance == 1

end

%% evaluation for small scale: fd vs duty cycle of zigbee
if enFdDutyCycle == 1
    dc3 = 0.01:0.01:0.1;
    [eva3, fig3] = eva_small_fd_dutycycle(sf, nsf, zq, wq, zw, dc3, ww, wf);
end

%% evaluation for small scale: reliability vs wifi traffic
if enReliabilityWiFiTraffic == 1
    wf4 = 0.0375:0.0625:0.225;
    [eva4, fig4] = eva_small_reliability_wifitraffic(sf, nsf, zq, wq, zw, zs, ww, wf4);
end

%% evaluation for small scale: reliability vs duty cycle
if enReliabilityDutyCycle == 1
    dc5 = 0.01:0.01:0.1;
    [eva5, fig5] = eva_small_reliability_dutycycle(sf, nsf, zq, wq, zw, dc5, ww, wf);
end

%% evaluation for small scale: reliability vs dissemination time
if enReliabilityDisseTime == 1
    [eva6, fig6] = eva_wifi_th_floodfrq(sf, nsf, zq, wq, zw, dc6, ww, wf);
end

%% evaluation for wifi routing: throughput vs flooding frequency
if enThFloodFreq == 1
    dc7 = 0.01:0.01:0.1;
    [eva7, fig7] = eva_wifi_th_floodfrq(sf, nsf, zq, wq, zw, dc7, ww, wf);
end

%% evaluation for wifi routing: transmission vs number of hops
if enTransmissionHop == 1
    numhop = 4;
    [eva8, fig8] = eva_wifi_tr_hop(numhop, sf, nsf, wr, zw, zs, ww, wf, mq);
end

%% evaluation for mesh network: delay vs link quality
if enLargeMeshLQ == 1
    lq =  [0.55:0.05:0.95];
    [eva9, fig9] = eva_mesh_delay_lq(sf, nsf, lq, zw, zs, ww, wf);
end

%% evaluation for mesh network: delay vs node number
if enLargeMeshNm == 1
    Nm =  [100:100:500];
    [eva10, fig10] = eva_mesh_delay_nm(sf, nsf, Nm, mq, zw, zs, ww, wf);
end

%% evaluation for small scale: number of received packets vs duty cycle of zigbee
if enRePacketsDutyCycle == 1
    dc11 = 0.01:0.01:0.1;
    [eva11, fig11] = eva_small_repackets_dutycycle(sf, nsf, zq, wq, zw, dc11, ww, wf);
end

%% evaluation for small scale: fd vs wifi traffic
if enRePacketsWiFiTraffic == 1
    wf12 = 0.1:0.0625:0.6;
    [eva12, fig12] = eva_small_repackets_wifitraffic(sf, nsf, zq, wq, zw, zs, ww, wf12);
end