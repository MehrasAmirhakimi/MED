clc
clear all
close all

TV0 = 70;
TF = 40;
Tsw = 25;
ER = linspace(0.5, 2.5, 10);
n = 3:8;
input = [n(1), ER(1), 0.75, 50, 0.035, TV0, Tsw, 6];
output1 = zeros(numel(n), numel(ER));
output2 = zeros(numel(n), numel(ER));

TVn = zeros(numel(n), 1);
dT = zeros(numel(n), 1);

for i = 1:numel(n)
    
    input(1) = n(i);
    f = @(x) (TV0 - x)/n(i) - 0.6 - (TF - Tsw)/log((x - Tsw)/(x - TF));
    options = optimoptions('fsolve', 'Display', 'off');
    TVn(i) = fsolve(f, TF + 1, options);
    dT(i) = (TV0 - TVn(i))/n(i) - 0.6;
    
   for j =1:numel(ER)
       
       input(2) = ER(j);
       input(8) = dT(i);
       y = MED(input, dT(i));
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       
   end
   
   
end

figure(1);
plot(ER, output1,'LineWidth',1.5);
xlabel('Entrainment Ratio');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');

figure(2);
plot(ER, output2,'LineWidth',1.5);
xlabel('Entrainment Ratio');
ylabel('SHTA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');