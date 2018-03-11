function [status, meandelay, maxdelay] = pando(lqdeploy, sourcefile, forzigbee, zigwake, zigsleep, wifiwake, wifitraffic)

packetsize = size(sourcefile,2);
time = 0;
table = [];

%link quality status dynamic table
lqsdt = [];

for i = 1:1:size(lqdeploy(:,3))
    if ~ismember(lqdeploy(i,3), lqsdt)
        lqsdt = [lqsdt;lqdeploy(i,3)];
    end
end

numr = size(lqsdt,1); 
nodelq = zeros(numr,1);
rxstatus = zeros(numr,1);
destatus = zeros(numr,1);
delay = zeros(numr,1);
lqsdt = [lqsdt, nodelq, rxstatus, destatus, delay];

for i = 1:1:numr
    table{i} = [];
end

while ~all(lqsdt(:,4)>0)
    time = time + 1;
    ws = worksequence(forzigbee, time, zigwake, zigsleep, wifiwake, wifitraffic);
    if ws == 1
        for i = 1:1:numr
            if lqsdt(i,4) == 1
                lqsdt(i,3) = 1;
            end
        end

        for i = 1:1:numr
            unlq = 1;
            routeid = find(lqdeploy(:,3) == lqsdt(i,1));
            for j = 1:1:size(routeid,1)
                s_id = lqdeploy(routeid(j,1),2);
                if s_id == 0
                   pstatus = 1;
                else
                   t_id = find(lqsdt(:,1) == s_id);
                   pstatus = lqsdt(t_id, 3);
                end
                unlq = (1-pstatus*lqdeploy(routeid(j,1),end))*unlq;
            end
            lq = 1 - unlq;
            lqsdt(i,2) = lq;
        end


        [code, degree, neighborlist] = fountainencode(sourcefile);


        for i = 1:1:size(lqsdt,1)
            noderxstatus = linkstatus(lqsdt(i,2));
            lqsdt(i,3) = noderxstatus;
            lqneighborlist = noderxstatus * neighborlist;

            % Generate table.
            % The tables describes in each fountain code, which data is combined and what is the result.
            % It is similar to the A and b in the system of unlinear equations Ax = b.
            table{i} = gentable(packetsize, table{i}, lqneighborlist, code);


            [decodestatus, decode] = fountaindecode(packetsize, table{i}); 

            if decodestatus == 1 && lqsdt(i,4) ==0
                lqsdt(i,4) = 1;
                lqsdt(i,5) = time;
            end
        end
        
    end
end
status = lqsdt;
meandelay = sum(lqsdt(:,end))/size(lqsdt,1);
maxdelay = max(lqsdt(:,end));
end