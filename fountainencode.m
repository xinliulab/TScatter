function [code, degree,neighborlist] = fountainencode(sourcefile)
    % The function consists of 3 steps:
    % 1st : Generate a random number (degree) based on the size of sourcefile. 
    % -- 1 <= degree <= size(sourcefile)
    % 2nd : Pick (degree) bytes randomly from the sourcefile, record their number.
    % -- gen-neighbor-list(..., ...)
    % Sort the number.
    % -- sort(...)
    % 3rd : Combine them using Xor
    % -- bitxor(...)
    
    
    % 1st step
    degree = gendegree(sourcefile); 
    
    % 2nd step
    neighborlist = sort(genneighborlist(sourcefile, degree));
    
    % 3rd step
    for i  = 1 : size(neighborlist, 2)
        if i == 1 
            code = bitxor(0, sourcefile(1, neighborlist(1,i)));
        elseif i > 1
            code = bitxor(code, sourcefile(1, neighborlist(1,i)));
        end
    end
end

