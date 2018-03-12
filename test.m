clc;
clear;

maxtime = 6;
numnode = 4;
timesort = zeros(maxtime,4);
timesort(:,1) = round([1:1:maxtime]');
time=[1,2,3;1,4,4;3,4,5;3,5,6];

for i = 1:1:size(time,2)
    i
       for j = 1:1:numnode
           j
           time
           timesort
           timesort(time(j,i), i+1) = timesort(time(j,i),i+1) + 1/4;
           if time(j,i)+1<=maxtime
                timesort(time(j,i)+1:end, i+1) = timesort(time(j,i), i+1);
           end
           timesort
       end
   end