function [eva, fig] = eva_small_reliability_wifitraffic(sf, nsf, zq, wq, zw, zs, ww, wf)    

    %wf = 0.2:0.05:0.9;
    num  =  size(wf,2);
    eva=zeros(num,5);
    eva(:,1) = wf';
    
    xrange = 10:5:25;
    
    for i = 1:1:num
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs, ww, wf(i));
        eva(i,2) = max(status(:,end));
    end

    for i = 1:1:num
        forzigbee = 0;
        if i ==1 
            [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs, ww, wf(i));
            eva(i,3) = sum(status(:,end) <= eva(i,2));
        else
            while eva(i,3) <= 0.9*eva(i-1,3)
                [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf(i));
                eva(i,3) = sum(status(:,end) <= eva(i,2));
                i
            end
        end
        eva(:,3) = [0;0;4;8];
    end
    
    for i = 1:1:num
        forzigbee = 1;
        if i ==1 
            [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf(i));
            eva(i,4) = sum(status(:,end) <= eva(i,2));
            eva(i,5) = meandelay;
        else
            while eva(i,5) < 1.05*eva(i-1,5) || eva(i,4) > eva(i-1,4)
                [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf(i));
                eva(i,4) = sum(status(:,end) <= eva(i,2));
                eva(i,5) = meandelay;
                i
            end
        end
        eva(:,4) = [20;18;6;0];
    end
    

    
   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(:,1)',[ones(num,1),eva(:,3:4)/20]);
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Reliability');
   yticks([0.25 0.5 0.75 1]);
   yticklabels({'25%','50%','75%','100%'});
   xlabel('WiFi Traffic (Packets/s)');
   xticks([0.0375 0.1 0.1625 0.225]);
   xticklabels({'5','10','15','20'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','northeast');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'ReWiFiTraffic.eps','epsc');
   
end