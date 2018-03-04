function y = gencombine(datasize, neighborlist)
    y = zeros(1, datasize);
    for i = 1 : size(neighborlist,2)
        y(1, neighborlist(i)) = 1;
    end
    
end