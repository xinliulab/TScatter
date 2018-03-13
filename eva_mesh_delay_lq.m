function [eva, fig] = eva_mesh_delay_lq(sf, nsf, lq, zw, zs, ww, wf)

num = size(lq,2);
nodenumber = 200;
iteration = 10;
networkrange = 65;
eva = zeros(num,4);
eva(:,1) = lq';
wr = networkrange;
zr = 10;
stdlq = 0;

for p = 1:1:iteration
    position = genposition(nodenumber,networkrange);
    
    forzigbee = 0;
    routingtable = findrouting(position, wr);
%         routingfigure(networkrange, position, routingtable);
    for i = 1:1:num
        for j = 1:1:iteration
            lqdeploy = callinkquality(position, routingtable, lq(i), stdlq);
            [status, meandelay, maxdelay] = pando(lqdeploy, sf, forzigbee, zw, zs, ww, wf);
            eva(i,2) = eva(i,2) + meandelay;
            
            [status, meandelay, maxdelay] = pando(lqdeploy, nsf, forzigbee, zw, zs, ww, wf);
            eva(i,3) = eva(i,2) + meandelay;
        end
    end

    
    forzigbee = 1;
    routingtable = findrouting(position, zr);
%         routingfigure(networkrange, position, routingtable);
    for i = 1:1:num
        for j = 1:1:iteration
            lqdeploy = callinkquality(position, routingtable, lq(i), stdlq);
            [status, meandelay, maxdelay] = pando(lqdeploy, sf, forzigbee, zw, zs, ww, wf);
            eva(i,4) = eva(i,4) + meandelay;
        end
    end
end

    eva(i,2) = eva(i,2) / iteration /iteration;
    eva(i,3) = eva(i,3) / iteration /iteration; 
    eva(i,4) = eva(i,4) / iteration /iteration; 
    
    
   fig = figure('Position',[0 250 800 350]); 
   h = bar(eva(:,1)',eva(:,2:4));
   set(h(1),'FaceColor','red');
   set(h(2),'FaceColor','black');
   set(h(3),'FaceColor','blue');
   
   ylabel('Flooding Delay (s)');
   xlabel('Link Quality');
   xticks([0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95]);
   xticklabels({'0.55','0.6','0.65','0.7','0.75','0.8','0.85','0.9','0.95'});
    
   legend('CRF','NCRF', 'PANDO', 'Location','northeast');
   set(gca,'FontSize',24);
   grid on;
%     print -deps FDDutyCycle
   saveas(gca, 'LargeMeshLQ.eps','epsc');
    
end


    