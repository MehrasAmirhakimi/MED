clc
clear all
close all


ER = linspace(0.5, 2.5, 10);
n = 3:8;
input = [n(1), ER(1), 0.75, 50, 0.035, 70, 25, 6];
output1 = zeros(numel(n), numel(ER));
output2 = zeros(numel(n), numel(ER));

for i = 1:numel(n)
    
    input(1) = n(i);
    dT = (input(6) - (input(7) + 17))/input(1);
    input(8) = dT;
    
   for j =1:numel(ER)
       
       input(2) = ER(j);
       y = MED(input, dT);
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       
   end
   
end

figure(1);
plot(ER, output1);
xlabel('Entrainment Ratio');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');

figure(2);
plot(ER, output2);
xlabel('Entrainment Ratio');
ylabel('SSA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');