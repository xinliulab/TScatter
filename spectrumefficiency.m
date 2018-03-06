function [sourcefile, decode, time, ntx, nrx] = spectrumefficiency(packetsize, linkquality, sleep, wake)
    % 1 cpu unit time == 1 packet 
    % Generate n bytes data randomly to construct the source file.
    % 1 byte == 1 packet
    sourcefile = gensourcefile(packetsize);
    
    table = [];
    % 0, continue; 1, finish!
    decodestatus = 0; 
    % number of times for transmission
    ntx = 0;
    time = 0;

    while(~decodestatus)
        for t = 1: sleep+wake
            time =  time + 1;
            if t > wake
%                fprintf('Sleep: %d\n', time);
            else
                % Generate code
                [code, degree, neighborlist] = fountainencode(sourcefile);    

                % Link Quality
                lqneighborlist = genlinkquality(linkquality) * neighborlist;

                ntx = ntx + 1;
%                 fprintf('Wake: %d\n', time);
                % Generate table.
                % The tables describes in each fountain code, which data is combined and what is the result.
                % It is similar to the A and b in the system of unlinear equations Ax = b.
                table = gentable(packetsize, table, lqneighborlist, code);


                [decodestatus, decode] = fountaindecode(packetsize, table); 

                if decodestatus == 1
%                     fprintf('Finish!\n');
                    break;
                end
            end
        end
    end
    nrx = size(table,1);
end