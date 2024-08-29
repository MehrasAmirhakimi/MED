clc
clear all
close all

n = 3:10;
TF = linspace(30, 45, 16);
TV0 = 70;
Tsw = 25;

TVn = zeros(numel(n), numel(TF));
dT = TVn;

for i = 1:numel(n)
    
   for j = 1:numel(TF) 
    
       f = @(x) (TV0 - x)/n(i) - 0.6 - (TF(j) - Tsw)/log((x - Tsw)/(x - TF(j)));
       options = optimoptions('fsolve', 'Display', 'off');
       TVn(i, j) = fsolve(f, TF(j) + 1, options);
       dT(i, j) = (TV0 - TVn(i, j))/n(i) - 0.6;
   end
    
end

[n1, TF1] = meshgrid(n, TF);
dT1 =dT';

surf(n1, TF1, dT1);
xlabel('n');
ylabel('TF');
zlabel('dT');