close all;
clear;
clc;

%Generate a row of hexadecimal numbers
sourceFile = randi([0,255],1,4);
degree = randi([1,size(sourceFile,2)]);
degreeNeighborList = randi([1,size(sourceFile,2)],1,degree);



