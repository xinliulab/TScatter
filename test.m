close all;
clear;
clc;

%%
packetsize = 5;
sourcefile = gensourcefile(packetsize);

%%
nodenumber = 10;
networkrange = 5;
position = genposition(nodenumber,networkrange);

%% find the routing and calculate its link quality (lq)
% communication range
comrange = 2;
routingtable = findrouting(position, comrange);
% mean of link quality
meanlq = 0.8;
% std of link quality
stdlq = 0.15; 

lqdeploy = callinkquality(position, routingtable, meanlq, stdlq);
% 
% 
% latency = pando(lqdeploy, sourcefile);
%  