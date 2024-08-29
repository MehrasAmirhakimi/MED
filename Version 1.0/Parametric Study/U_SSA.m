clc
clear all
close all

global U0

U = linspace(1, 2.5, 10);
n = 3:8;
TV0 = 70;
TF = 40;
Tsw = 25;
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

figure(1)
plot(U, output(1, :), '-o',...
    U, output(2, :), '-+',...
    U, output(3, :), '-*',...
    U, output(4, :), '-s',...
    U, output(5, :), '-x',...
    U, output(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Heat Transfer Coefficient [kW/(m^2.°C)]');
ylabel('SHSA [m^2.s/kg]');
pbaspect([1.25 1 1]);