function [eva, fig] = eva_mesh_delay_nm(sf, nsf, nm, mq, zw, zs, ww, wf)

num = size(nm,2);

zr = 10;
stdlq = 0;

eva = zeros(num,4);
eva(:,1) = nm';


    for i = 1:1:num
        nodenumber = nm(i);
        networkrange = sqrt(nm(i)*20);
        position = genposition(nodenumber,networkrange);
        wr = networkrange;
        routingtable = findrouting(position, wr);
        routingfigure(networkrange, position, routingtable);
        lqdeploy = callinkquality(position, routingtable, mq, stdlq);
        forzigbee = 0;
        [status, meandelay, maxdelay] = pando(lqdeploy, sf, forzigbee, zw, zs, ww, wf);
        eva(i,2) = meandelay;
        
        [status, meandelay, maxdelay] = pando(lqdeploy, nsf, forzigbee, zw, zs, ww, wf);
        eva(i,3) = meandelay;
        
        routingtable = findrouting(position, zr);
        routingfigure(networkrange, position, routingtable);
        lqdeploy = callinkquality(position, routingtable, mq, stdlq);
        forzigbee = 1;
        [status, meandelay, maxdelay] = pando(lqdeploy, sf, forzigbee, zw, zs, ww, wf);
        eva(i,4) = meandelay;
    end

   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(:,1)',eva(:,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Flooding Delay (s)');
   xlabel('Node Number');
%    xticks([0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95]);
%    xticklabels({'0.55','0.6','0.65','0.7','0.75','0.8','0.85','0.9','0.95'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','northeast');
   set(gca,'FontSize',24);
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'LargeMeshNm.eps','epsc');
    
end


    