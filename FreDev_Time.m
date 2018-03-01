x = 2:2:26;
y = [0.93 0.93 0.97 0.99 0.97 0.96 0.95 0.98 0.99 1.0 1.1 1.15 1.15];
err = 0.1*rand(1,size(y,2));
errorbar(x,y,err,'-s','MarkerSize',10,...
    'MarkerEdgeColor','black','MarkerFaceColor','black',...
    'color','black');
ylabel('Frequency Deviation (MHz)');
xlabel('Time (Hour )');
xticks([2:4:26]);
xlim([0 28]);
yticks([0.8 0.9 1 1.1 1.2]);
ylim([0.8 1.25]);


set(gca,'FontSize',24);
grid on;
print -deps FreDev_Time