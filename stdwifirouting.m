function [position, routingtable] = stdwifirouting(forzigbee, x, wr);
    position = [];
    for i=1:1:x
        position = [position; i, wr*(0.7*i), wr*(0.7*i)];
    end
    if forzigbee == 0
        routingtable = findrouting(position, x*wr);
    else
        routingtable = findrouting(position, wr);
    end
end