function [eva, fig] = eva_small_repackets_wifitraffic(sf, nsf, zq, wq, zw, zs, ww, wf)    

    %wf = 0.2:0.05:0.9;
    num  =  size(wf,2);
    eva=zeros(num,4);
    eva(:,1) = wf';
    iteration =20;
    
    xrange = 10:5:50;
    
    for i = 1:1:num
        forzigbee = 0;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs, ww, wf(i));
            eva(i,2) = eva(i,2) + sum(maxdelay-status(:,end))*wf(i);
            
            [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs, ww, wf(i));
            eva(i,3) = eva(i,3) + sum(maxdelay-status(:,end))*wf(i);
        end
    end

    
    for i = 1:1:num
        forzigbee = 1;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf(i));
            eva(i,4) = eva(i,4) + sum(maxdelay-status(:,end))*zw/zs;
        end
    end
    
    eva(:,2) = eva(:,2) / iteration;
    eva(:,3) = eva(:,3) / iteration;
    eva(:,4) = eva(:,4) / iteration;

    
   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(:,1)',eva(:,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Received Packets');
   xlabel('WiFi Traffic (Packets/s)');
   xticks([0.1 0.1625 0.225 0.2875 0.35 0.4125 0.475 0.5375 0.6]);
   xticklabels({'10','15','20','25','30','35','40','45','50'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','south', 'Orientation','horizontal');
   set(gca,'FontSize',24);
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'RevPacketWiFiTraffic.eps','epsc');
   
end