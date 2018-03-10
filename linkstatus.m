function status = linkstatus(lq)
    x = rand;
    if x < lq
        status = 1;
    else
        status = 0;
    end
end