function subcarrier = WiFi80211nData(symbolNumber, modulation)

bitsPerPt = log2(modulation); % bits per qam point

originalBit = randi([0 1],24*bitsPerPt, 1); % Code rate is 1/2, 48*1/2 = 24

bit_scramble = scrambler(originalBit);
bit_convolution = convolution(bit_scramble);



% QAM constellation, complex value, WiFi baseband in frequency domain
dataSubcarrier = qammod(bit_convolution, modulation, 'InputType', 'bit');


pilots = [1,1,1,-1];
position1 = mod(symbolNumber,4);
position1(position1 == 0) = length(pilots);
position2 = mod(symbolNumber+1,4);
position2(position2 == 0) = length(pilots);
position3 = mod(symbolNumber+2,4);
position3(position3 == 0) = length(pilots);
position4 = mod(symbolNumber+3,4);
position4(position4 == 0) = length(pilots);


subcarrier =[   zeros(6, 1); ...
                dataSubcarrier(1:5, :); ...
                pilots(position1); ... 
                dataSubcarrier(6:18, :); ...
                pilots(position2); ...
                dataSubcarrier(19:24, :); ...
                0; ...
                dataSubcarrier(25:30, :); ...
                pilots(position3); ...
                dataSubcarrier(31:43, :);  ...
                pilots(position4); ...
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