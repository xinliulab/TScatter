close all;
clear;
clc;

modulation = 64;
subcarrierNumber = 64;
symbolNumber = 0; %create 52 symbols, pilots + data subcarriers, 52 unknown values, rank is 52
testNum = 6; %test numbers
preNum = 12;

% Y0 = WiFi80211nData(symbolNumber, modulation);
Y0 = WiFi80211gData(symbolNumber, modulation);
Y = diag(Y0); % The polarity of the pilot subcarriers  is rolling changing.

ifftMx = zeros(subcarrierNumber, subcarrierNumber);
for n= 1:subcarrierNumber
    for k = 1:subcarrierNumber
        ifftMx(n,k) = exp(-1i*2*pi*(k-1)*(n-1)/subcarrierNumber);
    end
end

fftMx = 1/subcarrierNumber * conj(ifftMx);


Hf_val = complex(randn(subcarrierNumber,1),randn(subcarrierNumber,1));
Hf = diag(Hf_val); 
Hb_val = complex(randn(subcarrierNumber,1),randn(subcarrierNumber,1));
Hb = diag(Hb_val);
H = Hf*Hb;


flag = 1;
while flag == 1
    Bd = diag(randi([0 1],[subcarrierNumber,1])*2-1);
    B = fftMx * Bd * ifftMx;
    for n = 2:1:subcarrierNumber
        flag = 0;
        if abs(B(1,n)) < 0.000001
            flag = 1;
            break
        end
    end   
end
% disp(Bd);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Transmission  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Yo = inv(H) * fftMx * (ifftMx * Hb * fftMx) * (ifftMx * Hf * fftMx) * (ifftMx * Y);
fprintf('Yo equal to Y is %d\n', isequalMatrix(Y, Yo));

Yb = inv(H) * fftMx * (ifftMx * Hb * fftMx) * Bd * (ifftMx * Hf * fftMx) * (ifftMx * Y);
Yb1 = inv(H) * Hb * fftMx * Bd * ifftMx * Hf * Y;
Yb2 = inv(H) * H * inv(Hf) * fftMx * Bd * ifftMx * Hf * Y;
Yb3 = inv(Hf) * B * Hf * Y;
fprintf('Yb3 equal to Yb is %d\n', isequalMatrix(Yb3, Yb));

Yb30 = inv(Hf) * B * Hf * Y0;
fprintf('Sum of Yb30 equal to Yb3 is %d\n', isequalMatrix(sum(Yb3,2), Yb30));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  Verify Sylvester using non-zero subcarriers %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uidx = [7:11, 12, 13:25, 26, 27:32, 34:39, 40, 41:53, 54, 55:59]; % data subcarrier idx + 4 pilots

Yu = Y(uidx, uidx); 
Hfu = diag(Hf_val(uidx,:)); % useful channels
Bu = B(uidx, uidx);

Yb3u = inv(Hfu) * Bu * Hfu * Yu;

% Check
Ybu = Yb(uidx, uidx);
fprintf('Yb3u equal to Ybu is %d\n', isequalMatrix(Yb3u, Ybu));
fprintf('Sum of Yb3u equal to Yb30 is %d\n', isequalMatrix(sum(Yb3u,2), Yb30(uidx,:)));

% It cannot work to calculate Bu like this:
% ifftMxu = ifftMx(uidx, uidx);
% Bdu = Bd(uidx, uidx);
% fftMxu = fftMx(uidx, uidx);
% Bu = fftMxu * Bdu * ifftMxu;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  Calculate Hf using rank 52 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Due to the pilot values, the rank of Yu in 802.11n is 52 and invertible

A = Yb3u*inv(Yu);
X = Hfu;
fprintf('Sylvester equation is %d\n', isequalMatrix(A, inv(X)*Bu*X));

Hfus = ones(1,length(uidx));
for n = 2:1:length(uidx)
    Hfus(n) = A(1,n)/Bu(1,n);
end

% Check
cnt = 0;
Hft = diag([ones(1, 6), Hfus(1:26), 1, Hfus(27:52), ones(1, 5)]); % assume useless channel as 1

for idx = 1:1:2^testNum

    Yt = WiFi80211nData(symbolNumber, modulation); % The polarity of the pilot subcarriers  is rolling changing.
    Bdt = diag(randi([0 1],[subcarrierNumber,1])*2-1);
    Bt = fftMx * Bdt * ifftMx;

    if ~isequalMatrix(Bdt, Bd)

        Yb3t = inv(Hf) * Bt * Hf * Yt;
        Yb3st = inv(Hft) * Bt * Hft * Yt;

        if isequalMatrix(Yb3t(uidx,:), Yb3st(uidx,:))
            cnt = cnt + 1;
        end
    end
end

if cnt == 2^testNum
    display('Channel Estimation Success!');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  Decoding Backscatter Data  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y = diag(WiFi80211nData(symbolNumber, modulation));
preData = ones(preNum, 1);
tBit = randi([0 1],[64-preNum,1]);
Data = tBit*2-1;
Bd = diag([preData; Data]);


Yo = inv(H) * fftMx * (ifftMx * Hb * fftMx) * Bd * (ifftMx * Hf * fftMx) * (ifftMx * Y);
Yb = inv(H) * fftMx * (ifftMx * H * inv(Hft) * fftMx) * Bd * (ifftMx * Hft * fftMx) * (ifftMx * Y);
fprintf('Yo equal to Yb is %d\n', isequalMatrix(Yo, Yb));

You = Yo(uidx, uidx);
Ybu1 = Yb(uidx, uidx);
fprintf('You equal to Ybu1 is %d\n', isequalMatrix(Ybu1, You));


Hftu = diag(Hfus);
fftMxu = fftMx(uidx, :);
ifftMxu = ifftMx(:, uidx);
Yu = Y(uidx, uidx);
Ybu2 = inv(Hftu) * fftMxu * Bd * ifftMxu * Hftu * Yu;
fprintf('You equal to Ybu2 is %d\n', isequalMatrix(You, Ybu2));

% Yu is certain not estimated. So inv(Yu) does not increase BER.
% fftMxu(:,13:64) and ifftMxu(13:64, :) are invertible.
% CANNOT use invertible matrix of fftMxu(:,13:64) and ifftMxu(13:64) !!!!!
% Because their invertible matrixes have many zero collumns.
Btou = Hftu * You * inv(Yu) * inv(Hftu) - fftMxu(:,1:preNum) * diag(preData) * ifftMxu(1:preNum, :);
Btu = fftMxu(:,preNum+1:64) * diag(Data) * ifftMxu(preNum+1:64, :);
fprintf('Btou equal to Btu is %d\n', isequalMatrix(Btou, Btu));

% Due to MatLab
% Rank of Btou and Btu may be 50 or 51, and equal or unequal.
% We cannot use inv(fftMxu(:,preNum+1:64)) to calculate.
F = fftMxu(:,preNum+1:64);
I = ifftMxu(preNum+1:64,:);
fprintf('Btou(1,:) equal to F(1,:).*rot90(I,1)*Data is %d\n', ...
    isequalMatrix(rot90(Btou(1,:),1),  F(1,:).*rot90(I,1)*Data));

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
A =[];
b = [];
Aeq = [];
beq = [];
lb = -ones(64-preNum,1);
ub = ones(64-preNum,1);

iBit = lsqlin(iC,id,A,b,Aeq,beq,lb,ub);

disp([rBit, iBit, Data]);
[number,ratio] = biterr( (rBit+iBit) > 0, tBit);
fprintf('BER is %0.2f\n', ratio);

