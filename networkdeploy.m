function routetable = networkdeploy(position, scale)

%%
% test
% clear;
% clc;
% close all;
% number = 10;
% range = 5;
% position = genposition(number,range);
% scale =2;

%%
parent = [0];
child = position;
tempchild = position;
routetable = [0];

while size(child,1) ~= 0
%     flag = 1;
    d = [];
    local_route = [];
    for i = 1 : 1 : size(parent, 1)
        p_id = parent(i,end);
        if p_id == 0
            p_x = 0;
            p_y = 0;
        else
            p_x = position(p_id,end-1);
            p_y = position(p_id,end);
        end
        for j =  1 : 1 : size(child, 1)

            c_id = child(j,1);
            c_x = child(j,end-1);
            c_y = child(j,end);
            
            if (c_x - p_x)^2 + (c_y - p_y)^2 <= scale^2 
                local_route = [local_route;p_id,c_id];
            end             
        end
    end
    
    if size(local_route) ~= [0,0]
        
        parent = sort(unique(local_route(:,2)));    
        for p = 1 : 1 : size(parent,1)
            tempchild(parent(p,1),:) = [0];
        end
        child = tempchild(any(tempchild,2),:);

        temptable = [];
        for i = 1:1:size(routetable,1)
            for j = 1:1:size(local_route,1)
                if routetable(i,end) == local_route(j,1)
                    temptable = [temptable;[routetable(i,:),local_route(j,2)]];
                else
                    temptable = [temptable;[routetable(i,:),0]];

                end

            end

        end
        routetable = unique(temptable, 'rows');
    else
        break
    end
end

end

