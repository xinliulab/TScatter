function [eva, fig] = eva_small_fd_dutycycle(sf, zq, wq, zw, dc, ww, wf)
    
    %dc = 0.01:0.01:0.1;
    zs = zw./dc;
    num  =  size(zs,2);
    eva=zeros(num,3);
    eva(:,1) = dc';
    
    for i = 1:1:num
        forzigbee = 1;
        [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs(i), ww, wf);
        eva(i,2) = meandelay;
    end

    for i = 1:1:num
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs(i), ww, wf);
        eva(i,3) = meandelay;
    end
    
   fig = figure('Position',[0 250 800 350]); 
   plot(eva(:,1),eva(:,2));
   hold on
   plot(eva(:,1),eva(:,3));
   hold off
   
   ylabel('Flooding Latency (s)');
   xlabel('Duty-cycle');
   xticks([0:0.01:0.1]);
   xlim([0 0.1]);
%    yticks([0:100:500]);
%    ylim([0 600]);

% dim = [.4 .6 .3 .3];
% str = 'Fake figure';
% annotation('textbox',dim,'String',str,'FitBoxToText','on','Color','red','FontSize',24);

    set(gca,'FontSize',24);
    grid on;
    print -deps FDDutyCycle
end