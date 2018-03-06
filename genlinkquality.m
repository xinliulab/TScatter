function select = genlinkquality(LQ)
    x = rand;
    if x < LQ
        select = 1;
    else
        select = 0;
    end
end