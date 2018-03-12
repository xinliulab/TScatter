function [eva, fig] = eva_wifi_th_floodfrq(sf, nsf, zq, wq, zw, dc, ww, wf)
    
    zs = zw./dc;
    num  =  size(zs,2);
    eva=zeros(num,4);
    eva(:,1) = dc';
    
    for i = 1:1:num
        ThCRF = 10*dc+30;
        ThNCRF = 10*dc*size(SF,2)/size(NSF,2)+30;
        ThXPRESS = 30 - 10*dc; 
    end
    
end