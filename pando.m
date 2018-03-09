% function latency = pando(lqdeploy)
clear;
close;
clc;
lqdeploy = [
    1.0000         0    1.0000    0.0885    0.9943;
    2.0000         0    2.0000    0.6350    0.9662;
    3.0000         0    4.0000    2.4802    0.7154;
    4.0000         0    6.0000    1.0060    0.9231;
    5.0000         0    7.0000    0.2874    0.9832;
    6.0000         0    8.0000    1.9453    0.7857;
    7.0000         0   10.0000    1.1811    0.8418;
    8.0000    2.0000    3.0000    2.7743    0.6441;
    9.0000    8.0000    5.0000    1.0610    0.9140;
   10.0000    8.0000    9.0000    1.6055    0.7937;
   11.0000   10.0000    3.0000    3.2277    0.5859;
   12.0000   10.0000    5.0000    2.6142    0.6672;
   13.0000   10.0000    9.0000    3.5922    0.5854];

idnum = unique(lqdeploy(:,2:3));

%link quality status dynamic table
lqsdt = [];

for i = 1:1:size(lqdeploy(:,3))
    if ~ismember(lqdeploy(i,3), lqsdt)
        lqsdt = [lqsdt;lqdeploy(i,3)];
    end
end

numr = size(lqsdt,1);
lqsdt = [lqsdt, zeros(numr,1)];
k = 0;

for i = 1:1:numr
    unlq = 1;
    routeid = find(lqdeploy(:,3) == lqsdt(i));
    for j = 1:1:size(routeid,1)
        unlq = (1-lqdeploy(routeid(j,1),end))*unlq;
    end
    lq = 1 - unlq;
    lqsdt(i,end) = lq;
    lqsdt
end