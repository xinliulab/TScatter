close all;
clear;
clc;

eva = [  50    1901    4593    14452;
        100    1984    4619    17887;
        150    2060    4693    19817;
        200    1817    4617    21356]

fig = figure('Position',[0 250 800 350]); 
h = bar(eva(1:end,1)',eva(1:end,2:4));
set(h(1),'FaceColor','red');
set(h(2),'FaceColor','black');
set(h(3),'FaceColor','blue');

ylabel('Flooding Delay');
xlabel('Network Size');
xticks([50 100 150 200]);
xticklabels({'50','100','150','200'});

legend('CRF','BCRF', 'PANDO', 'Location','northwest','Orientation','horizontal');
set(gca,'FontSize',24,'FontWeight', 'bold');
% set(gca, 'YScale', 'log');
grid on;
%     print -deps FDDutyCycle
saveas(gca, 'LargeMeshNm.eps','epsc');