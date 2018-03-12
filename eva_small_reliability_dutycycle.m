function [eva, fig] = eva_small_reliability_dutycycle(sf, nsf, zq, wq, zw, dc, ww, wf)    

    %dc = 0.01:0.01:0.1;
    numnode = 20;
    zs = zw./dc;
    num  =  size(zs,2);
    eva=zeros(num,4);
    eva(:,1) = dc';
    iteration = 20;
    maxv = 0;
    
    for i = 1:1:num
        forzigbee = 0;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs(i), ww, wf);
            maxv = maxv + max(status(:,end));
            fprintf('CRF'); [i, j]
        end            
        eva(i,2) = maxv/iteration;
        maxv = 0;
    end

    for i = 1:1:num
        forzigbee = 0;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs(i), ww, wf);
            maxv = maxv + sum(status(:,end) <= eva(i,2));
            fprintf('NCRF'); [i, j]
        end 
        eva(i,3) = maxv/iteration;
        maxv = 0;
    end
    
    for i = 1:1:num
        forzigbee = 1;
        for j = 1:1:iteration
            [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs(i), ww, wf);
            maxv = maxv + sum(status(:,end) <= eva(i,2));
            fprintf('PANDO'); [i, j]
        end
        eva(i,4) = maxv/iteration;
        maxv = 0;
    end
    

    
   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(:,1)',[ones(num,1),eva(:,3:4)/numnode]);
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Reliability');
   yticks([0.25 0.5 0.75 1]);
   yticklabels({'25%','50%','75%','100%'});
   xlabel('Duty Cycle');
   xticks([0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]);
   xticklabels({'1%','2%','3%','4%','5%','6%','7%','8%','9%','10%'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','northeast');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'ReDutyCycle.eps','epsc');
   
end