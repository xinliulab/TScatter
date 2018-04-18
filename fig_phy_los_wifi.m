close all;
clear;
clc;

eva = [ 1    54*0.8452*11/12        54*0.8452*95/115 ;
        2    54*0.8452*11/12*9/12    54*0.8452*100/115*65/90 ;
        3    54*0.8452*11/12*9/12*7/9    54*0.8452*95/115*100/115*55/85]

fig = figure('Position',[0 250 400 260]); 
h = bar(eva(1:end,1)',eva(1:end,2:3));
set(h(1),'FaceColor','blue');
set(h(2),'FaceColor','red');

ylabel('Throughput (Mb/s)');
xlabel('Distance (m)');
% xticks([50 100 150 200]);
xticklabels({'0.5','3','10'});

legend('1 ZigBee','2 ZigBee', 'Location','northeast');
set(gca,'FontSize',20,'FontWeight', 'bold');
% set(gca, 'YScale', 'log');
grid on;
%     print -deps FDDutyCycle
saveas(gca, 'PhyLoSWiFi.eps','epsc');