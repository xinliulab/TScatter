close all;
clear;
clc;

j=1:7;
Xx = 0:0.5:3;
Yx = exp(Xx/1.2);

Xc = 0:0.5:3;
Yc = exp(Xc/1.9);

Xd = 0:0.5:3;
Yd = exp(Xd/1.5);

for i = 1:7
    Xpress(1,i) = 23-i*Yx(1,i)/18;
end

for i = 1:7
    CRF(1,i) = 23-i*Yc(1,i)/18;
    %CRF(1,i)=23*(0.8542*(i/9)+(1-i/9));
end

for i = 1:7
    NCRF(1,i) = 23-i*Yd(1,i)/18;
    %DCRF(1,i) = 23*(0.8542*(i/7)+(1-i/7));
end

% plot(j,CRF,'r',j,NCRF,'k',j,Xpress,'b','LineWidth',1.6);
% lgd = legend('CRF','NCRF','XRPESS','location','South','Orientation','horizontal');
% lgd.FontSize = 16;
% lgd.FontWeight = 'bold';
% set(gca,'Xticklabel',{'3','6','9','12','15','18','21'},'fontsize',24);
% xlabel('Flooding Packets')
% ylabel('Throughput (Mbps)')
% ylim([14 24])

   fig = figure('Position',[0 250 800 350]); 
   
   plot(j,CRF,'-', 'Color','r','LineWidth',4);
   hold on
   plot(j,NCRF,'-.','Color','k','LineWidth',4);
   hold on
   plot(j,Xpress,':','Color','b','LineWidth',4);
   hold off

   
   ylabel('Throughput (Mbps)');
   ylim([14 24]);
   yticks([14 16 18 20 22 24]);
   yticklabels({'14', '16', '18','20', '22', '24'});
   
   xlabel('Flooding Packets');
   xticklabels({'3','6','9','12','15','18','21'});


   legend('CRF','BCRF','XRPESS','location','South','Orientation','horizontal');
   set(gca,'FontSize',24,'FontWeight', 'bold');
    
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'ReDisseTime.eps','epsc');
   

