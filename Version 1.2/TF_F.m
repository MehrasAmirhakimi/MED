clc
clear all
close all

TF = linspace(30, 35, 10);
n = 3:8;
input = [n(1), 1, 0.75, 50, 0.035, 70, 25, 6];
output = zeros(numel(n), numel(TF));
output2 = zeros(numel(n), numel(TF)+1);
for i = 1:numel(n)
    
    dT = (input(6) - (input(7) + 15))/n(i);
    TVn = input(6) - n(i)*(dT + 0.6);
    input(1) = n(i);
    output2(i, 1) = dT;
    for j =1:numel(TF)
        
       dTc = (TF(j) - input(7))/log((TVn - input(7))/(TVn - TF(j)));
       input(8) = dTc;
       y = MED(input, dT);
       output(i, j) = y.x(4);
       output2(i, j+1)=dTc;
    end
   
end

plot(TF, output);
xlabel('Feed Water Temperature');
ylabel('Feed Water Flow Rate');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');

figure
plot(0:numel(TF), output2);