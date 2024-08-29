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


figure(1);
plot(TV0, output1,'LineWidth',1.5);
xlabel('Driving Steam Temperature [°C]');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure(2);
plot(TV0, output2,'LineWidth',1.5);
xlabel('Driving Steam Temperature [°C]');
ylabel('SHTA [m^2.s/kg]');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure(3);
plot(TV0, dT,'LineWidth',1.5);
xlabel('Driving Steam Temperature [°C]');
ylabel('Temperature Difference [°C]');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');