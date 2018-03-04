function gauss = fountaindecode(codecache, combinetable)   
       
%     source = [78; 31; 212; 6; 145];
%     codecache = [18; 67; 223; 142; 67; 151];
%     combinetable = [1     1     1     1     1;
%      0     0     1     1     1;
%      1     0     0     0     1;
%      0     1     0     0     1;
%      0     0     1     1     1;
%      0     0     0     1     1];
 
    block = [combinetable, codecache]; 
    ax = unique(block, 'rows', 'stable');
    nx = rank(ax);
 
    gauss = zeros(size(ax)); 
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
%              status = 1;
         elseif flag == 0 && gauss(end, end-1) == 0
             fprintf('Go on!');
%              status = 0;
         else
             ax(flag,:) = [];
             flag = 0;
         end
    end

end

 