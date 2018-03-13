close all;
clear;
clc;
   
neweva = [1, 1.0657, 1.0997, 1.0856;
         2, 2.0863, 2.2242, 2.1596;
         3, 3.0986, 3.3934, 3.2405;
         4, 4.1020, 4.5027, 4.3442]



fig = figure('Position',[0 250 800 350]); 
h = bar(neweva(:,1)',neweva(:,2:4));
set(h(1),'FaceColor','red');
set(h(2),'FaceColor','black');
set(h(3),'FaceColor','blue');

ylabel('Average Transmission Number');
xlabel('Number of Hops');

xticks([1 2 3 4]);
xticklabels({'1','2','3','4'});

legend('CRF','NCRF', 'PANDO', 'Location','north','Orientation','horizontal');
set(gca,'FontSize',24,'FontWeight', 'bold');


%     print -deps FDDutyCycle
saveas(gca, 'TranHop.eps','epsc');
