function [eva, fig] = eva_small_fd_wifitraffic(sf, nsf, zq, wq, zw, zs, ww, wf)    

    %wf = 0.2:0.05:0.9;
    num  =  size(wf,2);
    eva=zeros(num,4);
    eva(:,1) = wf';
    
    xrange = 10:5:50;
    
    for i = 1:1:num
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs, ww, wf(i));
        eva(i,2) = meandelay;
    end

    for i = 1:1:num
        forzigbee = 1;
        if i ==1 
            [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf(i));
            eva(i,3) = meandelay;
        else
            while eva(i,3) < 1.05*eva(i-1,3)
                [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf(i));
                eva(i,3) = meandelay;
                i
            end
        end
    end
    
    for i = 1:1:num
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs, ww, wf(i));
        eva(i,4) = meandelay;
    end
    
   fig = figure('Position',[0 250 800 350]); 
   plot(xrange',eva(:,2),'-', 'Color','r','LineWidth',4);
   hold on
   plot(xrange',eva(:,3),':','Color','b','LineWidth',4);
   hold on
   plot(xrange',eva(:,4),'-.','Color','k','LineWidth',4);
   hold off
   
   ylabel('Flooding Delay (s)');
   xlabel('Packets/s');
   xticks(xrange);
   xlim([10 50]);

   legend('CRF','PANDO', 'NCRF', 'Location','northwest');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'FDWiFiTraffic.eps','epsc');
   
end