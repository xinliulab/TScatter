close all;
clear;
clc;

%%
% Spectrum Efficiency
clear
linkquality_scale = 0.05;
linkquality_iteration = 20; %Please manual1y set: 1/0.05
iteration = 20;

data_delay = zeros(linkquality_iteration,2);

for j = 1: 1: linkquality_iteration
    linkquality  = j * linkquality_scale;
    delay = 0;
    for i = 1 : 1 : iteration
        [sourcefile, decode, time, ntx, nrx] = spectrumefficiency(6, linkquality, 100, 10);
        delay = delay + time;
    end
    averagedelay = round(delay / iteration);
    data_delay(j, :) = [linkquality, averagedelay];
end

x = data_delay(:,1);
y = data_delay(:,2);

fig_delay = figure('Position',[0 250 800 350]);
line(x', y')

set(gca,'GridAlpha',0.8);
set(gca,'LineWidth',1.6);
% legend(p,{'ZigBee Radio','Bacscatter'},'Location','northwest','Orientation','horizontal');

% fig.PaperPositionMode = 'auto';
% 
% fig_pos = fig.PaperPosition;
% 
% fig.PaperSize = [fig_pos(3) fig_pos(4)];

print('SpectrumEfficiency','-depsc')
