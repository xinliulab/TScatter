function lq = genlinkquality(num, meanval, stdval)
    if meanval + stdval > 1 || meanval - stdval <0
        fprintf('Wrong imput for mean and std');
    else
        x = randn(num,1);
        lq = x - mean(x) + meanval;
        lq = lq / std(x) * stdval;
    
end