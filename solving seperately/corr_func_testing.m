clc
clear all
close all
T = linspace(-300, 2000, 1000);

y3 = FuncPsat(T);

plot(T, y3);

m3i = (y3(2)-y3(1))/(T(2)-T(1))

m3f = (y3(end)-y3(end-1))/(T(end)-T(end-1))