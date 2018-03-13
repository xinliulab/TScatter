close all;
clear;
clc;

   
   eva = cell2mat(struct2cell(load('eva_delay_dutycycle.mat')));
   times = 353 / eva(2,end);
   
   
   
   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(1:end-1,1)',eva(1:end-1,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Flooding Delay (s)');
   xlabel('Duty Cycle');

   xticks([0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45]);
   xticklabels({'5%','10%','15%','20%','25%','30%','35%','40%', '45%'});
   
   legend('CRF','NCRF', 'PANDO', 'Location','north','Orientation','horizontal');
   set(gca,'FontSize',24,'FontWeight', 'bold');
%    set(gca, 'YScale', 'log');
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'FDDutyCycle.eps','epsc');
