clc
clear all
close all

n = 3:8;
TF = 40;
TV0 = linspace(60, 70, 10);
Tsw = 25;

TVn = zeros(numel(n), numel(TV0));
dT = zeros(numel(n), numel(TV0));

input = [n(1), 1, 0.75, 50, 0.035, TV0(1), 25, 6];
output1 = zeros(numel(n), numel(TV0));
output2 = zeros(numel(n), numel(TV0));


for i = 1:numel(n)
    
    input(1) = n(i);
    
    for j = 1:numel(TV0)
       
       f = @(x) (TV0(j) - x)/n(i) - 0.6 - (TF - Tsw)/log((x - Tsw)/(x - TF));
       options = optimoptions('fsolve', 'Display', 'off');
       TVn(i, j) = fsolve(f, TF + 1, options);
       dT(i, j) = (TV0(j) - TVn(i, j))/n(i) - 0.6;
       input(6) = TV0(j);
       input(8) = dT(i, j);
       y = MED(input, dT(i, j));
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       
    end
    
end

figure(1)
plot(TV0, output1(1, :), '-o',...
    TV0, output1(2, :), '-+',...
    TV0, output1(3, :), '-*',...
    TV0, output1(4, :), '-s',...
    TV0, output1(5, :), '-x',...
    TV0, output1(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Driving Steam Temperature [°C]');
ylabel('GOR');
pbaspect([1.25 1 1]);

figure(2)
plot(TV0, output2(1, :), '-o',...
    TV0, output2(2, :), '-+',...
    TV0, output2(3, :), '-*',...
    TV0, output2(4, :), '-s',...
    TV0, output2(5, :), '-x',...
    TV0, output2(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Driving Steam Temperature [°C]');
ylabel('SHSA [m^2.s/kg]');
pbaspect([1.25 1 1]);

figure(3)
plot(TV0, dT(1, :), '-o',...
    TV0, dT(2, :), '-+',...
    TV0, dT(3, :), '-*',...
    TV0, dT(4, :), '-s',...
    TV0, dT(5, :), '-x',...
    TV0, dT(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Driving Steam Temperature [°C]');
ylabel('Temperature Difference [°C]');
pbaspect([1.25 1 1]);