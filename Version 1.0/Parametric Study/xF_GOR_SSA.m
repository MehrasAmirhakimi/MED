clc
clear all
close all

TV0 = 70;
TF = 40;
Tsw = 25;
xF = linspace(0.015, 0.050, 10);
n = 3:8;
input = [n(1), 1, 0.75, 50, xF(1), TV0, Tsw, 6];
output1 = zeros(numel(n), numel(xF));
output2 = zeros(numel(n), numel(xF));

TVn = zeros(numel(n), 1);
dT = zeros(numel(n), 1);

for i = 1:numel(n)

    input(1) = n(i);
    f = @(x) (TV0 - x)/n(i) - 0.6 - (TF - Tsw)/log((x - Tsw)/(x - TF));
    options = optimoptions('fsolve', 'Display', 'off');
    TVn(i) = fsolve(f, TF + 1, options);
    dT(i) = (TV0 - TVn(i))/n(i) - 0.6;
    
   for j =1:numel(xF)
       
       input(5) = xF(j);
       input(8) = dT(i);
       y = MED(input, dT(i));
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       
   end
   
end

figure(1)
plot(xF, output1(1, :), '-o',...
    xF, output1(2, :), '-+',...
    xF, output1(3, :), '-*',...
    xF, output1(4, :), '-s',...
    xF, output1(5, :), '-x',...
    xF, output1(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Sea Water Concentration [kg/kg]');
ylabel('GOR');
pbaspect([1.25 1 1]);

figure(2)
plot(xF, output2(1, :), '-o',...
    xF, output2(2, :), '-+',...
    xF, output2(3, :), '-*',...
    xF, output2(4, :), '-s',...
    xF, output2(5, :), '-x',...
    xF, output2(6, :), '-d', 'LineWidth',1.25);
legend('n = 3','n = 4','n = 5','n = 6','n = 7','n = 8','Location','NorthEastOutside');
xlabel('Sea Water Concentration [kg/kg]');
ylabel('SHSA [m^2.s/kg]');
pbaspect([1.25 1 1]);