close all;
clear;
clc;



%%
nodenumber = 100;
networkrange = 50;
% position = genposition(nodenumber,networkrange);

position = std100point(1);

%% find the routing
forzigbee = 1;

if forzigbee == 1 
    comrange = 8; % communication range
else
    comrange = networkrange;
end


routingtable = findrouting(position, comrange);

fig = routingfigure(networkrange, position, routingtable);
