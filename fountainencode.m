function y = fountainencode(sourceFile, degreeNeighborList)
    
    % sourceFile is a row of hexadecimal numbers
    for i = 1: size(degreeNeighborList,2)
        if i + 1 <= size(degreeNeighborList,2)
           y = bitxor(sourceFile(1,i), sourceFile(1,i));
        end
    end
end



