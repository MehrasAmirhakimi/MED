clc
clear all
close all

TV0 = linspace(60, 70, 10);
n = 3:8;
input = [n(1), 1, 0.75, 50, 0.035, TV0(1), 25, 6];
output1 = zeros(numel(n), numel(TV0));
output2 = zeros(numel(n), numel(TV0));
output3 = zeros(numel(n), numel(TV0));

for i = 1:numel(n)
    
    input(1) = n(i);
    
   for j =1:numel(TV0)
       
       input(6) = TV0(j);
       dT = (input(6) - (input(7) + 17))/input(1);
       input(8) = dT;
       y = MED(input, dT);
       output1(i, j) = y.GOR;
       output2(i, j) = y.SSA;
       output3(i, j) = dT;
   end
   
end

figure(1);
plot(TV0, output1);
xlabel('Driving Steam Temperature');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');

figure(2);
plot(TV0, output2);
xlabel('Driving Steam Temperature');
ylabel('SSA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');

figure(3);
plot(TV0, output3);
xlabel('Driving Steam Temperature');
ylabel('Temperature Difference');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');