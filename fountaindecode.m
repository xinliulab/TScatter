function [decodestatus, decode] = fountaindecode(packetsize, table)   
    % The function works as Gauss elimination.
    % 1st : Find the first element whose value equals to 1 in each column.
    % 2nd : Store the row to the matrix named 'gauss'.
    % 3rd : Find other elements whose value also equals to 1. 
    % 4th : Use the first row to xor the other rows.
    % 5th : Delete the first row.
    % 6th : Repeat above steps in 2nd, 3rd... columns until the end.
    % 7th : If gauss(end, end-1) ==1, we could decode all the code.
    % 8th : Decode the code form the last row to the first row.

    % flga == 1 means the first non-zero element at the specific column.
    flag = 0; 
    
    gauss = zeros(packetsize, packetsize+1);
    decode = gauss(:, end);
    
    % Preprocess: delete the same rows.
    ax = unique(table, 'rows', 'stable');
    
    if size(ax, 1) < packetsize
        
        decodestatus = 0;          
        
    else
        % 6th step
        for rk = 1 : packetsize
            % 1st step
             for i = 1 : size(ax,1) 
                 if ax(i, rk) == 1 && flag == 0 
                    flag = i;
                    % 2nd step
                    gauss(rk,:) = ax(i,:);
                    % 3rd step
                 elseif ax(i, rk) == 1 && flag ~= 0
                    % 4th step 
                    ax(i, :) = bitxor(ax(flag,:), ax(i,:));
                 end
             end
             % 7th step
             % Have not found the specific element on diagonal
             if flag == 0 && gauss(end, end-1) == 0
                 decodestatus = 0;
                 break;
             end
             if flag ~= 0 && gauss(end, end-1) == 0
                 % 5th step
                 ax(flag,:) = [];
                 ax = unique(ax, 'rows', 'stable');
                 flag = 0;
                 decodestatus = 0;
                 % Check if need to continue
                 if size(ax,1) + rk < packetsize
                     rk = packetsize;
                 end
             end
             if gauss(end, end-1) ~= 0
                 decodestatus = 1;
                 rk = packetsize;
             end
        end
    end
    
    % 8th step
    if decodestatus == 1
        for k =  size(gauss, 1)-1 : -1 : 1
            for j = k+1 : size(gauss,1)
                if gauss(k, j) ~= 0
                    gauss(k,:) = bitxor(gauss(k, :), gauss(j, :));
                end
            end
        end
        decode = gauss(:, end);
    end

    
end