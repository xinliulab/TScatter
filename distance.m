function y = distance(s,d)
    y = (s(1,end)-d(1,end))^2 + (s(1,end-1)-d(1,end-1))^2;
end