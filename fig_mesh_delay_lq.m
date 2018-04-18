

close all;
clear;
clc;

eva = cell2mat(struct2cell(load('eva_mesh_delay_lq_copy.mat')));
eva(:,3) = eva(:,3) + 500;

fig = figure('Position',[0 250 800 350]); 
h = bar(eva(1:end-1,1)',eva(1:end-1,2:4));
set(h(1),'FaceColor','red');
set(h(2),'FaceColor','black');
set(h(3),'FaceColor','blue');

ylabel('Flooding Delay');
xlabel('Link Quality');
xticks([0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9]);
xticklabels({'0.55','0.6','0.65','0.7','0.75','0.8','0.85','0.9'});

legend('CRF','BCRF', 'PANDO', 'Location','north','Orientation','horizontal');
set(gca,'FontSize',24);
set(gca, 'YScale', 'log','FontWeight', 'bold');
grid on;
%     print -deps FDDutyCycle
saveas(gca, 'LargeMeshLQ.eps','epsc');
