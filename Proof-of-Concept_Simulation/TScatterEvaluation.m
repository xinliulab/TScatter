close all;
clear;
clc;

modulation = 64;
subcarrierNumber = 64;
symbolNumber = 1; %create 52 symbols, pilots + data subcarriers, 52 unknown values, rank is 52
preNum = 12;
testNum = 100; %test numbers
packetLength = 30; %packet length in each test 


ifftMx = zeros(subcarrierNumber, subcarrierNumber);
for n= 1:subcarrierNumber
    for k = 1:subcarrierNumber
        ifftMx(n,k) = exp(-1i*2*pi*(k-1)*(n-1)/subcarrierNumber);
    end
end

fftMx = 1/subcarrierNumber * conj(ifftMx);

uidx = [7:11, 12, 13:25, 26, 27:32, 34:39, 40, 41:53, 54, 55:59];

for test = 1:1:testNum

    Hf_val = complex(randn(subcarrierNumber,1),randn(subcarrierNumber,1));
    Hf = diag(Hf_val); 
    Hb_val = complex(randn(subcarrierNumber,1),randn(subcarrierNumber,1));
    Hb = diag(Hb_val);
    H = Hf*Hb;
    
    flag = 1;
    while flag == 1
        Bce = diag(randi([0 1],[subcarrierNumber,1])*2-1);
        B = fftMx * Bce * ifftMx;
        for n = 2:1:subcarrierNumber
            flag = 0;
            if abs(B(1,n)) < 0.000001
                flag = 1;
                break
            end
        end   
    end


    % Backscatter Transmission
    Y0 = WiFi80211gData(0, modulation);
    Y = diag(Y0); % The polarity of the pilot subcarriers  is rolling changing.
    Yb = inv(H) * fftMx * (ifftMx * Hb * fftMx) * Bce * (ifftMx * Hf * fftMx) * (ifftMx * Y);
    
    % Channel Estimation
    Yu = Y(uidx, uidx); 
    Ybu = Yb(uidx, uidx);
    Bu = B(uidx, uidx);
    A = Ybu*inv(Yu);

    Hfus = ones(1,length(uidx));
    for n = 2:1:length(uidx)
        Hfus(n) = A(1,n)/Bu(1,n);
    end
    Hftu = diag(Hfus);

    % Evaluation
    for symbolTest = 1:1:packetLength
        Ye = diag(WiFi80211nData(symbolNumber, modulation));
        Yeu = Ye(uidx, uidx);
        preData = ones(preNum, 1);
        tBit = randi([0 1],[64-preNum,1]);
        Data = tBit*2-1;
        Bde = diag([preData; Data]);
        fftMxu = fftMx(uidx, :);
        ifftMxu = ifftMx(:, uidx);
        F = fftMxu(:,preNum+1:64);
        I = ifftMxu(preNum+1:64,:);
        
        % Transmission
        Yo = inv(H) * fftMx * (ifftMx * Hb * fftMx) * Bde * (ifftMx * Hf * fftMx) * (ifftMx * Ye);
        You = Yo(uidx, uidx);

        % Decoding 
        Btou = Hftu * You * inv(Yeu) * inv(Hftu) - fftMxu(:,1:preNum) * diag(preData) * ifftMxu(1:preNum, :);
        
        C = F(1,:).*rot90(I,1);
        d = rot90(Btou(1,:),1);

        rC = real(C);
        rd = real(d);
        A =[];
        b = [];
        Aeq = [];
        beq = [];
        lb = -ones(64-preNum,1);
        ub = ones(64-preNum,1);

        rBit = lsqlin(rC,rd,A,b,Aeq,beq,lb,ub);

        iC = imag(C);
        id = imag(d);

        iBit = lsqlin(iC,id,A,b,Aeq,beq,lb,ub);

        % BER
        [number,ratio] = biterr( (rBit+iBit) > 0, tBit);
        if ratio > 0
            fprintf('BER is %0.2f\n', ratio);
        end
        filename = 'TScatterBER.txt';
        logRecord(filename, test, symbolTest, number, ratio);
    end

end