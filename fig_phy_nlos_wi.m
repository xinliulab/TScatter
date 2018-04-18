close all;
clear;
clc;

eva = [ 1    54*0.8452*11/12/2        54*0.8452*95/115/2 ;
        2    54*0.8452*11/12*9/12/2.2    54*0.8452*100/115*65/90/2.2 ;
        3    54*0.8452*11/12*9/12*7/9/2.5    54*0.8452*95/115*100/115*55/85/2.5]

fig = figure('Position',[0 250 400 260]); 
h = bar(eva(1:end,1)',eva(1:end,2:3));
set(h(1),'FaceColor','blue');
set(h(2),'FaceColor','red');

ylabel('Throughput (Mb/s)');
ylim([0 50]);
xlabel('Distance (m)');
% xticks([50 100 150 200]);
xticklabels({'0.5','3','10'});

legend('1 ZigBee','2 ZigBee', 'Location','northeast');
set(gca,'FontSize',20,'FontWeight', 'bold');
% set(gca, 'YScale', 'log');
grid on;
%     print -deps FDDutyCycle
saveas(gca, 'PhyNLoSWiFi.eps','epsc');