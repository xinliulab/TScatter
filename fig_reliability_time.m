
close all;
clear;
clc;

  timesort = cell2mat(struct2cell(load('eva_realiability_time.mat')));

   fig = figure('Position',[0 250 800 350]); 
  
   plot(timesort(:,1),timesort(:,2),'-', 'Color','r','LineWidth',4);
   hold on
   plot(timesort(:,1),timesort(:,3),'-.','Color','k','LineWidth',4);
   hold on
   plot(timesort(:,1),timesort(:,4),':','Color','b','LineWidth',4);
   hold off

   
   ylabel('Reliablity');
   yticks([0.25 0.5 0.75 1]);
   yticklabels({'25%','50%','75%','100%'});
   ylim([0,1]);
   xlabel('Dissemination Time (s)');
   xlim([0, timesort(end,1)]);
%    xticks(xrange);
%    xlim([10 50]);

   legend('CRF','NCRF', 'PANDO', 'Location','southeast');


    set(gca,'FontSize',24,'FontWeight', 'bold');
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'ReDisseTime.eps','epsc');
   