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


plot(TF, output,'LineWidth',1.5);
xlabel('Feed Water Temperature');
ylabel('Feed Water Flow Rate');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure
plot(TF, dT,'LineWidth',1.5);
xlabel('Feed Water Temperature');
ylabel('Temperature Difference');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure
plot(TF, output3,'LineWidth',1.5);
xlabel('Feed Water Temperature');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure
plot(TF, output4,'LineWidth',1.5);
xlabel('Feed Water Temperature');
ylabel('SHTA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');