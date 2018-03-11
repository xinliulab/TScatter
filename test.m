close all;
clear;
clc;

%%
packetsize = 6;
sourcefile = gensourcefile(packetsize);

%%
nodenumber = 20;
networkrange = 8;
position = genposition(nodenumber,networkrange);

%% find the routing
forzigbee = 1;

if forzigbee == 1 
    comrange = 4; % communication range
else
    comrange = networkrange;
end
routingtable = findrouting(position, comrange);
fig = routingfigure(networkrange, position, routingtable);

%% set link quality (lq)
% mean and std value of link quality
meanlq = 0.8;
stdlq = 0.15;
lqdeploy = callinkquality(position, routingtable, meanlq, stdlq);

%% set wireless traffic
zigwake = 10;
zigsleep = 100;
wifiwake = 2;
wifitraffic = 0.8;


%% run pando
[status meandelay maxdelay] = pando(lqdeploy, sourcefile, forzigbee, zigwake, zigsleep, wifiwake, wifitraffic)



    