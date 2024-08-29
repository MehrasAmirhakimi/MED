clc
clear all
close all

global U0

U = linspace(2000, 2500, 10);
n = 3:8;
input = [n(1), 1, 0.75, 50, 0.035, 70, 25, 6];
output = zeros(numel(n), numel(U));

for i = 1:numel(n)
    
    input(1) = n(i);
    dT = (input(6) - (input(7) + 17))/input(1);
    input(8) = dT;
    
   for j =1:numel(U)
       
       U0 = U(j);
       y = MED(input, dT);
       output(i, j) = y.SSA;
   end
   
end

plot(U, output);
xlabel('Heat Transfer Coefficient');
ylabel('SSA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');