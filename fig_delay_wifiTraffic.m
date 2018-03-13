close all;
clear;
clc;

xrange = 10:5:50;

eva = cell2mat(struct2cell(load('eva_delay_wifitraffic.mat')));   

fig = figure('Position',[0 250 800 350]); 
plot(xrange',eva(:,2),'-', 'Color','r','LineWidth',4);
hold on
plot(xrange',eva(:,3),'-.','Color','k','LineWidth',4);
hold on
plot(xrange',eva(:,4),':','Color','b','LineWidth',4);
hold off


ylabel('Flooding Delay (s)');
xlabel('WiFi Occupancy Rate');
xticks(xrange);
xlim([10 50]);
xticklabels({'10%','15%', '20%', '25%', '30%', '35%', '40%', '45%','50%'});

legend('CRF','NCRF', 'PANDO', 'Location','north', 'Orientation','horizontal');


set(gca,'FontSize',24);
grid on;
%     print -deps FDWiFiTraffic.eps
saveas(gca, 'FDWiFiTraffic.eps','epsc');