clc
clear all
close all


xF = linspace(0.015, 0.050, 10);
n = 3:8;
input = [n(1), 1, 0.75, 50, xF(1), 70, 25, 6];
output1 = zeros(numel(n), numel(xF));
output2 = zeros(numel(n), numel(xF));

for i = 1:numel(n)
    i
    dT = (input(6) - (input(7) + 20))/input(1);
    input(1) = n(i);
    input(8) = dT;
    
   for j =1:numel(xF)
       j
       input(5) = xF(j);
       y = MED(input, dT);
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       
   end
   
end

figure(1);
plot(xF, output1);
xlabel('Sea Water Concentration');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');

figure(2);
plot(xF, output2);
xlabel('Sea Water Concentration');
ylabel('SSA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');