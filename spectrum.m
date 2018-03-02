close all;
clear;
clc;

x = 0.1:0.1:1;
y = [0.93 0.93 0.97 0.99 0.97 0.96 0.95 0.98 0.99 1.0];
err = 0.1*rand(1,size(y,2));

fig=figure('Position',[0 250 800 350]);

errorbar(x,y,err,'-s','MarkerSize',10,...
    'MarkerEdgeColor','black','MarkerFaceColor','black',...
    'color','black');
ylabel('Spectrum Efficiency');
xlabel('Link quality');
xticks([0:0.1:1]);
xlim([0 1.1]);
yticks([0.8 0.9 1 1.1 1.2]);
ylim([0.85 1.1]);

dim = [.4 .6 .3 .3];
str = 'Fake figure';
annotation('textbox',dim,'String',str,'FitBoxToText','on','Color','red','FontSize',24);

set(gca,'FontSize',24);
grid on;
print -deps Spectrum