function  lqdeploy = callinkquality(position, routingtable, lqmean, lqstd)
    
    local_route = [];
    for i = 2:1:size(routingtable, 2)
        for j = 1:1:size(routingtable,1)
            if routingtable(j,i) ~= 0
                local_route = [local_route; routingtable(j,i-1:i)];
            end
        end
    end
        
    table = unique(local_route,'rows');
    table = [[1:1:size(table,1)]',table];
    temp = table;
    
    table = [table,zeros(size(table,1),1)];
    for i = 1:1:size(table,1)
        s_id = table(i,end-2);
        d_id = table(i,end-1);
        if s_id == 0
            table(i,end) =  distance(zeros(1,size(table,2)), position(d_id,:));
        else
            table(i,end) = distance(position(s_id,:),position(d_id,:));
        end
    end
          
    table = sortrows(table,size(table,2));
    
    lq = genlinkquality(size(table,1), lqmean, lqstd);
    lq = sortrows(lq,'descend');
    lqd = [table, lq];
    
    lqdeploy = sortrows(lqd,'ascend');
    
end