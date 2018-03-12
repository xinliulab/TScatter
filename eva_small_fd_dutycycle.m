function [eva, fig] = eva_small_fd_dutycycle(sf, nsf, zq, wq, zw, dc, ww, wf)
    
    %dc = 0.01:0.01:0.1;
    zs = zw./dc;
    num  =  size(zs,2);
    eva=zeros(num,4);
    eva(:,1) = dc';
    
    for i = 1:1:num
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs(i), ww, wf);
        eva(i,2) = meandelay;
    end

    for i = 1:1:num
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs(i), ww, wf);
        eva(i,3) = meandelay;
    end
    
    for i = 1:1:num
        forzigbee = 1;
        if i == 1
            [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs(i), ww, wf);
            eva(i,4) = meandelay;
        else
            while eva(i,4) == 0 || eva(i,4) >=  0.95*eva(i-1,4)
                [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs(i), ww, wf);
                eva(i,4) = meandelay;
                i
            end
        end
    end
    
 
 
   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(:,1)',eva(:,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Flooding Delay (s)');
   xlabel('Duty Cycle');
   xticks([0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]);
   xticklabels({'1%','2%','3%','4%','5%','6%','7%','8%','9%','10%'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','northeast');
   set(gca,'FontSize',24);
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'FDDutyCycle.eps','epsc');
end