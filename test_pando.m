close all;
clear;
clc;

%%
packetsize = 6;
% sourcefile = gensourcefile(packetsize);
sourcefile = stdsourcefile(1);

%%
nodenumber = 20;
networkrange = 20;
% position = genposition(nodenumber,networkrange);
position = std20point(1);

%% find the routing
forzigbee = 1;

if forzigbee == 1 
    comrange = 6; % communication range
else
    comrange = networkrange;
end
% routingtable = findrouting(position, comrange);
% fig = routingfigure(networkrange, position, routingtable);

%% set link quality (lq)
% mean and std value of link quality
meanlq = 0.8;
stdlq = 0.15;
% lqdeploy = callinkquality(position, routingtable, meanlq, stdlq);

% set wireless traffic
zigwake = 50;
zigsleep = 500;
wifiwake = 10;
wifitraffic = 0.5;


%% run pando
lqdeploy = stdziglinkdeploy(1);
wf = 0.2:0.1:0.9;
num  =  size(wf,2);
for i = 1:1:num
    hold on
    forzigbee = 1;
    [status, meandelay, maxdelay] = pando(lqdeploy, sourcefile, forzigbee, zigwake, zigsleep, wifiwake, wf(i));
    meandelay
end

% [status, meandelay, maxdelay] = pando(lqdeploy, sourcefile, forzigbee, zigwake, zigsleep, wifiwake, wifitraffic);




    