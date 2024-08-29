clc
clear all
close all

n = 3:8;
TF = linspace(30, 45, 16);
TV0 = 70;
Tsw = 25;

TVn = zeros(numel(n), numel(TF));
dT = zeros(numel(n), numel(TF));

input = [n(1), 1, 0.75, 50, 0.035, TV0, Tsw, 6];
output = zeros(numel(n), numel(TF));
output3 = zeros(numel(n), numel(TF));
output4 = zeros(numel(n), numel(TF));

for i = 1:numel(n)
    
    input(1) = n(i);
    
    for j = 1:numel(TF) 
    
       f = @(x) (TV0 - x)/n(i) - 0.6 - (TF(j) - Tsw)/log((x - Tsw)/(x - TF(j)));
       options = optimoptions('fsolve', 'Display', 'off');
       TVn(i, j) = fsolve(f, TF(j) + 1, options);
       dT(i, j) = (TV0 - TVn(i, j))/n(i) - 0.6; 
       input(8) = dT(i, j);
       y = MED(input, dT(i, j));
       output(i, j) = y.x(4);
       output3(i, j) = y.GOR;
       output4(i, j) = y.SSA;
    
    end
    
end

figure(1)
plot(TF, output(1, :), '-o',...
    TF, output(2, :), '-+',...
    TF, output(3, :), '-*',...
    TF, output(4, :), '-s',...
    TF, output(5, :), '-x',...
    TF, output(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Feed Water Temperature [°C]');
ylabel('GOR');
pbaspect([1.25 1 1]);

figure(2)
plot(TF, dT(1, :), '-o',...
    TF, dT(2, :), '-+',...
    TF, dT(3, :), '-*',...
    TF, dT(4, :), '-s',...
    TF, dT(5, :), '-x',...
    TF, dT(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Feed Water Temperature [°C]');
ylabel('Temperature Difference [°C]');
pbaspect([1.25 1 1]);

figure(3)
plot(TF, output3(1, :), '-o',...
    TF, output3(2, :), '-+',...
    TF, output3(3, :), '-*',...
    TF, output3(4, :), '-s',...
    TF, output3(5, :), '-x',...
    TF, output3(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Feed Water Temperature [°C]');
ylabel('GOR');
pbaspect([1.25 1 1]);

figure(4)
plot(TF, output4(1, :), '-o',...
    TF, output4(2, :), '-+',...
    TF, output4(3, :), '-*',...
    TF, output4(4, :), '-s',...
    TF, output4(5, :), '-x',...
    TF, output4(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Feed Water Temperature [°C]');
ylabel('SHSA [m^2.s/kg]');
pbaspect([1.25 1 1]);