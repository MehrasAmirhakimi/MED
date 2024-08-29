clc
clear all
close all

t = linspace(0, 100, 100);
x = linspace(0, 0.050, 100);

[T, X] = meshgrid(t, x);

dT = BPE(T, X);

surf(T, X, dT)