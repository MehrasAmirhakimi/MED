clc
clear all
close all

global U0

U = linspace(1, 2.5, 10);
n = 3:8;
TV0 = 70;
TF = 40;
Tsw = 25;
n = 3:8;
input = [n(1), 1, 0.75, 50, 0.035, TV0, Tsw, 6];
output = zeros(numel(n), numel(U));


TVn = zeros(numel(n), 1);
dT = zeros(numel(n), 1);

for i = 1:numel(n)
    
    input(1) = n(i);
    f = @(x) (TV0 - x)/n(i) - 0.6 - (TF - Tsw)/log((x - Tsw)/(x - TF));
    options = optimoptions('fsolve', 'Display', 'off');
    TVn(i) = fsolve(f, TF + 1, options);
    dT(i) = (TV0 - TVn(i))/n(i) - 0.6;
    
   for j = 1:numel(U)
       
       U0 = U(j);
       input(8) = dT(i);
       y = MED(input, dT(i));
       output(i, j) = y.SSA;
       
   end
   
   
end

figure;
plot(U, output,'LineWidth',1.5);
xlabel('Heat Transfer Coefficient');
ylabel('STHA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects','Location','NorthEastOutside');