function [eva, fig] = eva_small_repackets_dutycycle(sf, nsf, zq, wq, zw, dc, ww, wf)
    
    %dc = 0.01:0.01:0.1;
    zs = zw./dc;
    num  =  size(zs,2);
    eva=zeros(num,4);
    eva(:,1) = dc';
    iteration =20;
    
    for i = 1:1:num
        forzigbee = 0;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs(i), ww, wf);
            eva(i,2) = eva(i,2) + sum(maxdelay-status(:,end))*wf;
        end
    end

    for i = 1:1:num
        forzigbee = 0;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs(i), ww, wf);
            eva(i,3) = eva(i,3) + sum(maxdelay-status(:,end))*wf;
        end
    end
    
    for i = 1:1:num
        forzigbee = 1;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs(i), ww, wf);
            eva(i,4) = eva(i,4) + sum(maxdelay-status(:,end))*dc(i);
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
   xlabel('Duty Cycle');
   xticks([0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]);
   xticklabels({'1%','2%','3%','4%','5%','6%','7%','8%','9%','10%'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','south', 'Orientation','horizontal');
   set(gca,'FontSize',24);
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'RevPacketDutyCycle.eps','epsc');
end