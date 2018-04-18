close all;
clear;
clc;

   
   eva1 = cell2mat(struct2cell(load('eva_delay_dutycycle.mat')));
   times_crf = 14.3 / eva1(2,2);
   times_ncrf = 47 / eva1(2,3);
   times_pando = 353 / eva1(2,end);
   diff = [1.8:1.8:1.8+1.8*(size(eva1,1)-1)];
   
   neweva = eva1;
   neweva(:,2) = eva1(:,2)*times_crf;
   neweva(:,3) = eva1(:,3)*times_ncrf-diff';
   neweva(:,4) = eva1(:,4)*times_pando;
   neweva(1,4) = neweva(1,4)-40;
   
   
   
   fig = figure('Position',[0 250 800 350]); 
   h = bar(neweva(1:end-1,1)',neweva(1:end-1,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Flooding Delay (s)');
   xlabel('Duty Cycle');

   xticks([0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45]);
   xticklabels({'5%','10%','15%','20%','25%','30%','35%','40%', '45%'});
   
   legend('CRF','BCRF', 'PANDO', 'Location','north','Orientation','horizontal');
   set(gca,'FontSize',24,'FontWeight', 'bold');
   set(gca, 'YScale', 'log');
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'FDDutyCycle.eps','epsc');
