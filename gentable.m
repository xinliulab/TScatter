function table = gentable(packetsize, pretable, neighborlist, code)
    % This function works as a cache. 
    % It stores all the neighbor and code and generates a matrix.
    % The matrix describles A and b in the system of unlinear equations Ax = b.
    % 1st : Generate a new full width list as a row.
    % -- E.g. The list is [1,3,4] and the packets size is 5. 
    % -- Then the new full width list is [1, 0, 1, 1, 0].
    % 2nd : Add the code to the end of the new list and get a longer list.
    % 3rd : Add the longer list to the end of the prior table.
    
    if neighborlist ~= zeros(1, size(neighborlist, 2)) 
        % 1st step    
        shortlist = zeros(1, packetsize);
        for i = 1 : size(neighborlist,2)
            shortlist(1, neighborlist(1, i)) = 1;
        end

        % 2nd step
        longlist = [shortlist, code];

        % 3rd step
        table = [pretable; longlist];
    else
        table = pretable;
    end
    
end