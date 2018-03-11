function y = eva_small_fd_wifitraffic(sourcefile, zigwake, zigsleep, wifiwake, wifitraffic)


forzigbee = 1;

if forzigbee == 1 
    comrange = 6; % communication range
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

% set wireless traffic
zigwake = 10;
zigsleep = 100;
wifiwake = 2;
wifitraffic = 0.8;    

for wifitraffic = 0.55:0.05:0.9

    [status meandelay maxdelay] = pando(lqdeploy, sourcefile, forzigbee, zigwake, zigsleep, wifiwake, wifitraffic)

end
end