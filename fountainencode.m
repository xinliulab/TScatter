function y = fountainencode(sourcefile, neighborlist)
    for i  = 1 : size(neighborlist, 2)
        if i == 1 
            y = bitxor(0, sourcefile(1, neighborlist(1,i)));
        elseif i > 1
            y = bitxor(y, sourcefile(1, neighborlist(1,i)));
        end
    end
end



