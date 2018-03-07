function y = networkdeploy(number, range, scale)

parent = [0];
position = [[1:number]',rand(number,2)*range - range/2]; 
child = position;
route = [];

while size(child,1) ~= 0
    k = 1;
    d = [];
    for i = 1 : 1 : size(parent, 1)
        if parent(i) == 0
            p_x = 0;
            p_y = 0;
        else
            p_x = position(parent(i,end),end-1);
            p_y = position(parent(i,end),end-1);
        end
        for j =  1 : 1 : size(child, 1)

            c_id = child(j,1);
            c_x = child(j,end-1);
            c_y = child(j,end);
            
            if (c_x - p_x)^2 + (c_y - p_y)^2 <= scale^2
                route = [route; parent(i), c_id];
                k = k + 1;
                d = [d;j];
            end
        end
    end
    parent = route;
    for p = 1 : 1 : size(d,1)
        child(d(p,:)-p+1,:) = [];
    end

end

y = route;

end