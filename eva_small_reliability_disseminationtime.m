function [timesort, fig] = eva_small_reliability_disseminationtime(sf, nsf, zq, wq, zw, zs, ww, wf)    

    numnode = 20;
    iteration = 50;
    time = zeros(numnode,3);
    

    forzigbee = 0;
    for j = 1:1:iteration
        [status, meandelay, maxdelay] = pando(wq, sf, forzigbee, zw, zs, ww, wf);
        time(:,1) = time(:,1) + status(:,end);
        fprintf('CRF'); 
        j
    end            
    time(:,1) = sort(round(time(:,1)/iteration));


    forzigbee = 0;
    for j = 1:1:iteration
        [status, meandelay, maxdelay] = pando(wq, nsf, forzigbee, zw, zs, ww, wf);
        time(:,2) = time(:,2) + status(:,end);
        fprintf('NCRF'); 
        j
     end 
     time(:,2) = sort(round(time(:,2)/iteration));
    
     forzigbee = 1;
     for j = 1:1:iteration
         [status, meandelay, maxdelay] = pando(zq, sf, forzigbee, zw, zs, ww, wf);
         time(:,3) = time(:,3) + status(:,end);
         fprintf('PANDO'); 
         j
     end
     time(:,3) = sort(round(time(:,3)/iteration));
    
   maxtime = max(time(:,3));
   timesort = zeros(maxtime,4);
   timesort(:,1) = [1:1:maxtime]';   
   for i = 1:1:size(time,2)
       for j = 1:1:numnode
           timesort(time(j,i), i+1) = timesort(time(j,i),i+1) + 1/20;
           if time(j,i)+1<=maxtime
                timesort(time(j,i)+1:end, i+1) = timesort(time(j,i), i+1);
           end
       end
   end
     
     
   fig = figure('Position',[0 250 800 350]); 
   
   
   plot(timesort(:,1),timesort(:,2),'-', 'Color','r','LineWidth',4);
   hold on
   plot(timesort(:,1),timesort(:,3),'-.','Color','k','LineWidth',4);
   hold on
   plot(timesort(:,1),timesort(:,4),':','Color','b','LineWidth',4);
   hold off

   
   ylabel('Reliablity');
   yticks([0.25 0.5 0.75 1]);
   yticklabels({'25%','50%','75%','100%'});
   ylim([0,1]);
   xlabel('Dissemination Time (s)');
   xlim([0, maxtime]);
%    xticks(xrange);
%    xlim([10 50]);

   legend('CRF','NCRF', 'PANDO', 'Location','southeast');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'ReDisseTime.eps','epsc');
   
end