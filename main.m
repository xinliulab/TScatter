close all;
clear;
clc;

%Generate n bytes data
datasize = 5;
%link quality
LQ = 0;

status = 0;

sourcefile = gensourcefile(datasize);

codecache = [];
combinetable = [];

while(1)
    %Generate code
    degree = gendegree(sourcefile);
    neighborlist = sort(genneighborlist(sourcefile, degree));
    code = fountainencode(sourcefile, neighborlist);
    
    
    %Link Quality
    
    codecache = [codecache; code];
    combine= gencombine(datasize, neighborlist);
    combinetable = [combinetable; combine];
    
    block = [combinetable, codecache]; 
    ax = unique(block, 'rows', 'stable');
    nx = rank(ax);
 
    gauss = zeros(datasize, datasize+1); 
    flag = 0; % flga == 1 means the first non-zero number at diagonal
 
    for rk = 1 : nx % the kth of rank, also the numbers of iteration
         for i = 1 : size(ax,1) 
             if ax(i, rk) == 1 && flag == 0 
                flag = i;
                gauss(rk,:) = ax(i,:);% store the first non-zero row 
             elseif ax(i, rk) == 1 && flag ~= 0
                ax(i, :) = bitxor(ax(flag,:), ax(i,:));
             end
         end
         if flag == 0 && gauss(end, end-1) ~= 0
             fprintf('Finish!\n');
             status = 1;
             break
         elseif flag == 0 && gauss(end, end-1) == 0
             fprintf('Go on!\n');
             status = 0;
         else
             ax(flag,:) = [];
             flag = 0;
         end
    end
    
    if status == 1
        break
    end
    
%     %Decode code
%     data = fountaindecode(codecache, combinetable);
%     
%      
%     %Decode successfully
%     if data(end,end-1) == 1
%         break;
%     end 
end



