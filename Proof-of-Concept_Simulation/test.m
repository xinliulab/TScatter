close all;
clear;
clc;
subcarrierNumber = 8;
preNum = 12;

ifftMx = zeros(subcarrierNumber, subcarrierNumber);
for n= 1:subcarrierNumber
    for k = 1:subcarrierNumber
        ifftMx(n,k) = exp(-1i*2*pi*(k-1)*(n-1)/subcarrierNumber);
    end
end

fftMx = conj(ifftMx);

uidx = [2,3,5,7];

f = fftMx(uidx,3:6) * ifftMx(3:6, uidx)
d = randi([0 1],[4,1])*2-1
b = fftMx(uidx,3:6) * diag(d) * ifftMx(3:6, uidx)
rank(b)
