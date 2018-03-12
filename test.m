   
eva = importdata('eva_fig1_data.mat');

xrange = 10:5:50;


   fig = figure('Position',[0 250 800 350]); 
   plot(xrange',eva(:,2),'-', 'Color','r','LineWidth',4);
   hold on
   plot(xrange',eva(:,3),'-.','Color','k','LineWidth',4);
   hold on
   plot(xrange',eva(:,4),':','Color','b','LineWidth',4);
   hold off

   
   ylabel('Flooding Delay (s)');
   xlabel('Packets/s');
   xticks(xrange);
   xlim([10 50]);

   legend('CRF','NCRF', 'PANDO', 'Location','northwest');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'FDWiFiTraffic.eps','epsc');
 