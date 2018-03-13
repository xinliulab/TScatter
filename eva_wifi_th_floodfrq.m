function [eva, fig] = eva_wifi_th_floodfrq(sf, nsf, zq, wq, zw, dc, ww, wf)
    
    
    num  =  size(dc,2);
    eva=zeros(num,4);
    eva(:,1) = dc';
    
    for i = 1:1:num
        eva(i,2) = -26/28*10*dc(i)+30; % Throughput of CRF
        eva(i,3)= 10*dc(i)*size(sf,2)/size(nsf,2)+30; % Throughput of NCRF
        eva(i,4) = 30 - 10*dc(i); % Throughput of XPRESS
    end
    
   fig = figure('Position',[0 250 800 350]);
   plot(eva(:,1),eva(:,2),'-', 'Color','r','LineWidth',4);
   hold on
   plot(eva(:,1),eva(:,3),'-.','Color','k','LineWidth',4);
   hold on
   plot(eva(:,1),eva(:,4),':','Color','b','LineWidth',4);
   hold off

   
   ylabel('Throughput');
   xlabel('Flooding Frequency');

   legend('CRF','NCRF', 'XPRESS', 'Location','northwest');


    set(gca,'FontSize',24);
    grid on;
%     print -deps FDWiFiTraffic.eps
    saveas(gca, 'ThFloodingFreq.eps','epsc');
end