function position = genposition(number, range)
    % stream = RandStream.getGlobalStream;
    % savedState = stream.State;
%     rng(26,'twister');
    position = [[1:number]',rand(number,2)*range - range/2]; 
    
end