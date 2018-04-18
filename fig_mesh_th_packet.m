close all;
clear;
clc;

j=1:7;
Xx = 0:0.5:3;
Yx = exp(Xx/0.965);
 

Xc = 0:0.5:3;
Yc = exp(Xc/1.8);
 

Xd = 0:0.5:3;
Yd = exp(Xd/1.3);
 

for i = 1:7
    Xpress(1,i) = 23-i*Yx(1,i)/18;
end
 

for i = 1:7
    CRF(1,i) = 23-i*Yc(1,i)/18;
    %CRF(1,i)=23*(0.8542*(i/9)+(1-i/9));
end
 

for i = 1:7
    BCRF(1,i) = 23-i*Yd(1,i)/18;
    %DCRF(1,i) = 23*(0.8542*(i/7)+(1-i/7));
end

eva = zeros(7,4);
eva(:,1) = [3,6,9,12,15,18,21]';
eva(:,2) = CRF';
eva(:,3) = BCRF';
eva(:,4) = Xpress';

fig = figure('Position',[0 250 800 350]); 

   plot(eva(:,1),eva(:,2),'-', 'Color','r','LineWidth',4);
   hold on
   plot(eva(:,1),eva(:,3),'-.','Color','k','LineWidth',4);
   hold on
   plot(eva(:,1),eva(:,4),':','Color','b','LineWidth',4);
   hold off

ylabel('Throughput (Mbps)');
ylim([14 24]);
xlabel('Flooding Packets');
xticks([3 6 9 12 15 18 21]);
xticklabels({'3','6','9','12','15','18','21'});
xlim([3 21]);

legend('CRF','BCRF', 'XPRESS', 'Location','south','Orientation','horizontal');
set(gca,'FontSize',24,'FontWeight', 'bold');
% set(gca, 'YScale', 'log');
grid on;
%     print -deps FDDutyCycle
saveas(gca, 'LargeMeshPa.eps','epsc');

