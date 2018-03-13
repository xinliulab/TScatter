function [sf, nsf, po, nr, zr, wr, zt, wt, zq, wq, zw, zs, ww, wf, mq, sq] = setparameter(x)
% sf =  sourcefile;
% nsf = sourcefile for ncrt;
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

    sf = stdsourcefile(x);
    nsf = ncrtsourcefile(x);
    po = std20point(x);
    nr = 20;
    zr = 6;
    wr = 20;
    zt = findrouting(po, zr);
    %fig1 = routingfigure(nr, po, zt);
    wt = findrouting(po, wr);
    %fig2 = routingfigure(nr, po, wt);
    zq = stdziglinkdeploy(x);
    wq = stdwilinkdeploy(x);
    zw = 10;
    zs = 100;
    ww = 2;
    wf = 0.8;
    mq = 0.8;
    sq = 0.15;
    
    
end