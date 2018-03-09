function lq = genlinkquality(num, meanval, stdval)
    flag  = 0;
    
    if meanval + stdval > 1 || meanval - stdval <0
        fprintf('Wrong imput for mean and std');
    else
        while flag == 0 
            flag = 1;
            x = rand(num,1);
            lq = x / std(x) * stdval;
            lq = lq - mean(lq) + meanval;
            for i = 1 : 1 : size(lq,1)
                if lq(i, 1) > 1 || lq(i,1) < 0
                    flag = 0;
                end
            end
        end
    end
end