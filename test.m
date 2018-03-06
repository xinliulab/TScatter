close all;
clear;
clc;

[sourcefile, decode, time, ntx, nrx] = spectrumefficiency(6, 0.5, 100, 10);

s=sprintf('%d ', sourcefile);
fprintf('Source: %s\n', s);
d=sprintf('%d ', decode);
fprintf('Decode: %s\n', d);
fprintf('Delay: %d\n', time);
fprintf('Trasmit %d pacets\n', ntx);
fprintf('Receive %d pacets\n',nrx);