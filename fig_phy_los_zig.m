close all;
clear;
clc;

eva = [ 1    116.39        237 ;
        2    109    225 ;
        3    105    220]

fig = figure('Position',[0 250 400 260]); 
h = bar(eva(1:end,1)',eva(1:end,2:3));
set(h(1),'FaceColor','blue');
set(h(2),'FaceColor','red');

ylabel('Throughput (Kb/s)');
ylim([0 310]);
xlabel('Distance (m)');
% xticks([50 100 150 200]);
xticklabels({'4','7','10'});

legend('1 ZigBee','2 ZigBee', 'Location','north','Orientation', 'horizontal');
set(gca,'FontSize',20,'FontWeight', 'bold');
% set(gca, 'YScale', 'log');
grid on;
%     print -deps FDDutyCycle
saveas(gca, 'PhyLoSZig.eps','epsc');