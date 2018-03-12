function [eva, fig] = eva_wifi_tr_hop(numhop, sf, nsf, wr, zw, zs, ww, wf, mq)    
    
    eva = zeros(numhop,4);
    eva(:,1) = [1:1:numhop]';
    sq = 0;
    iteration = 20;
    
    for i =1:1:numhop
        % CRF
        forzigbee = 0;
        [po_c, rt_c] = stdwifirouting(forzigbee, i, wr);
        for j =1:1:iteration
            lq_c = callinkquality(po_c, rt_c, mq, sq);   
            [status_c, meandelay_c, maxdelay_c] = pando(lq_c, sf, forzigbee, zw, zs, ww, 0.5);
            eva(i,2) = eva(i,2) + max(status_c(:,end));
        end
        eva(i,2) = eva(i,2)/iteration;
        
        % NCRF
        forzigbee = 0;
        [po_n, rt_n] = stdwifirouting(forzigbee, i, wr);
        for j =1:1:iteration
            lq_n = callinkquality(po_n, rt_n, mq, sq);   
            [status_n, meandelay_n, maxdelay_n] = pando(lq_n, nsf, forzigbee, zw, zs, ww, 0.5);
            eva(i,3) = eva(i,3) + max(status_n(:,end));
        end
        eva(i,3) = eva(i,3)/iteration;
        
        % XPRESS
        forzigbee = 1;
        [po_x, rt_x] = stdwifirouting(forzigbee, i, wr);
        for j =1:1:iteration
            lq_x = callinkquality(po_x, rt_x, mq-0.1, sq);  
            [status_x, meandelay_x, maxdelay_x] = pando(lq_x, sf, forzigbee, 2, 2, 0, 0.5);
            eva(i,4) = eva(i,4) + max(status_x(:,end));
        end
        eva(i,4) = eva(i,4)/iteration;
    end
    
   fig = figure('Position',[0 250 800 350]);
   h = bar(eva(:,1)',eva(:,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Transmission');
%    yticks([0.25 0.5 0.75 1]);
%    yticklabels({'25%','50%','75%','100%'});
   xlabel('Number of hops');
   xticks([1 2 3 4]);
   xticklabels({'1','2','3','4'});
    
   legend('CRF','NCRF', 'XPRESS', 'Location','south','Orientation','horizontal');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'TranHop.eps','epsc');
end