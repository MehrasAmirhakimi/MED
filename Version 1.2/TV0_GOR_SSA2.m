clc
clear all
close all

n = 3:8;
TF = linspace(30, 45, 16);
TV0 = linspace(60, 70, 10);
Tsw = 25;

TVn = zeros(numel(TV0), numel(TF), numel(n));
dT = zeros(numel(TV0), numel(TF), numel(n));

for k = 1:numel(n)
    
   for i = 1:numel(TV0)
       
       for j = 1:numel(TF)
           
           f = @(x) (TV0(i) - x)/n(k) - 0.6 - (TF(j) - Tsw)/log((x - Tsw)/(x - TF(j)));
           options = optimoptions('fsolve', 'Display', 'off');
           TVn(i, j, k) = fsolve(f, TF(j) + 1, options);
           dT(i, j, k) = (TV0(i) - TVn(i, j, k))/n(k) - 0.6;
           
       end
       
   end
    
end

input = [n(1), 1, 0.75, 50, 0.035, TV0(1), 25, 6];
output1 = zeros(numel(TF), numel(V0), numel(n));
output2 = zeros(numel(TF), numel(V0), numel(n));
[TV0m, TFm] = meshgrid(TV0, TF);
ijk = 0
for k = 1:numel(n)
    
    input(1) = n(k);
    
    for i = 1:numel(TV0)
        
       for j = 1:numel(TF)
           
           input(6) = TV0m(j, i);
           input(8) = dT(i, j, k);
           y = MED(input, dT(i, j, k));
           output1(j, i, k) = y.GOR;
           output2(j, i, k) = y.SSA;
           ijk = ijk + 1
       end
        
    end
    
end

figure(1)
xlabel('Driving Steam Temperature')
ylabel('Feed Water Temperature');
zlabel('Temperature Difference')
hold on
figure(2)
xlabel('Driving Steam Temperature')
ylabel('Feed Water Temperature');
zlabel('GOR')
hold on
figure(3)
xlabel('Driving Steam Temperature')
ylabel('Feed Water Temperature');
zlabel('SSA')
hold on
for k = 1:numel(n)
    figure(1)
    surf(TV0m, TFm, dT(:, :, k)');
    figure(2)
    surf(TV0m, TFm, real(output1(:, :, k)));
    figure(3)
    surf(TV0m, TFm, real(output2(:, :, k)));
end