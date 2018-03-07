close all;
clear;
clc;

%%
% Spectrum Efficiency
clear
linkquality_scale = 0.05;
linkquality_begin = 0.55;

linkquality_iteration = round((1-linkquality_begin)/linkquality_scale+1); %Please manual1y set: 1/0.05
meaniteration = 50;

data_delay = zeros(linkquality_iteration,2);

for j = 1: 1: linkquality_iteration
    linkquality  = linkquality_begin + (j-1) * linkquality_scale;
    delay = 0;
    for i = 1 : 1 : meaniteration
        [sourcefile, decode, time, ntx, nrx] = spectrumefficiency(6, linkquality, 100, 10);
        delay = delay + time;
    end
    meandelay = round(delay / meaniteration);
    data_delay(j, :) = [linkquality, meandelay];
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
