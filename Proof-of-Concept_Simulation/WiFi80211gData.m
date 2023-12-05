function subcarrier = WiFi80211gData(symbolNumber, modulation)

bitsPerPt = log2(modulation); % bits per qam point

originalBit = randi([0 1],24*bitsPerPt, 1); % Code rate is 1/2, 48*1/2 = 24

bit_scramble = scrambler(originalBit);
bit_convolution = convolution(bit_scramble);

% QAM constellation, complex value, WiFi baseband in frequency domain
dataSubcarrier = qammod(bit_convolution, modulation, 'InputType', 'bit');


pilots = [1,1,1,1,-1,-1,-1,1,-1,-1,-1,-1,1,1,-1,1,-1,-1,1,1,-1,1,1,-1, ...
          1,1,1,1,1,1,-1,1,1,1,-1,1,1,-1,-1,1,1,1,-1,1,-1,-1,-1,1,-1,1, ...
         -1,-1,1,-1,-1,1,1,1,1,1,-1,-1,1,1,-1,-1,1,-1,1,-1,1,1,-1,-1,-1, ...
          1,1,-1,-1,-1,-1,1,-1,-1,1,-1,1,1,1,1,-1,1,-1,1,-1,1,-1,-1,-1,-1, ...
         -1,1,-1,1,1,-1,1,-1,1,1,1,-1,-1,1,-1,-1,-1,1,1,1,-1,-1,-1,-1,-1,-1,-1];

position = mod(symbolNumber, 127) + 1;


subcarrier =[   zeros(6, 1); ...
                dataSubcarrier(1:5, :); ...
                pilots(position);
                dataSubcarrier(6:18, :); ...
                pilots(position); ...
                dataSubcarrier(19:24, :); ...
                0; ...
                dataSubcarrier(25:30, :); ...
                pilots(position); ...
                dataSubcarrier(31:43, :);  ...
                -pilots(position); ...
                dataSubcarrier(44:48, :); ...
                zeros(5,1)]; 

end


function scrData = scrambler(data)
   N = 2;
   scramblerPoly = comm.Scrambler(N,'1 + z^-4 + z^-7', [1 0 1 1 1 0 1]);
   scrData = scramblerPoly(data);   
end

function code_convolution = convolution(code_scramble)
    t = poly2trellis(7,[171 133]); 
    k = log2(t.numInputSymbols); 
    code_convolution = convenc(code_scramble,t); 
end