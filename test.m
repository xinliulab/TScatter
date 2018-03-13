

close all;
clear;
clc;


position = std20point(1);
networkrange = 20;

%% find the routing
forzigbee = 1;

if forzigbee == 1 
    comrange = 6; % communication range
else
    comrange = networkrange;
end
routingtable = findtreerouting(position, comrange);
fig = routingfigure(networkrange, position, routingtable);

