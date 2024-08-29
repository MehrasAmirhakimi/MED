clc
clear all
close all

TV0 = 70;
TF = 40;
Tsw = 25;
R = linspace(0.45, 0.75, 10);
n = 3:8;
input = [n(1), 1, R(1), 50, 0.035, TV0, Tsw, 6];
output1 = zeros(numel(n), numel(R));
output2 = zeros(numel(n), numel(R));

TVn = zeros(numel(n), 1);
dT = zeros(numel(n), 1);

for i = 1:numel(n)
    
    input(1) = n(i);
    f = @(x) (TV0 - x)/n(i) - 0.6 - (TF - Tsw)/log((x - Tsw)/(x - TF));
    options = optimoptions('fsolve', 'Display', 'off');
    TVn(i) = fsolve(f, TF + 1, options);
    dT(i) = (TV0 - TVn(i))/n(i) - 0.6;
    
   for j =1:numel(R)
       
       input(3) = R(j);
       input(8) = dT(i);
       y = MED(input, dT(i));
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       
   end
   
   
end

figure(1);
plot(R, output1,'LineWidth',1.5);
xlabel('Recovery Ratio');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure(2);
plot(R, output2,'LineWidth',1.5);
xlabel('Recovery Ratio');
ylabel('SHSA [m^2.s/kg]');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');