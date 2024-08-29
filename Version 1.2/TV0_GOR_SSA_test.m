clc
clear all
close all

TV0 = linspace(60, 70, 10);
n = 3:8;
input = [n(1), 1, 0.75, 50, 0.015, TV0(1), 25, 6];
output1 = zeros(numel(n), numel(TV0));
output2 = zeros(numel(n), numel(TV0));
t = linspace(15, 18, 10);

figure(1);
hold on

figure(2);
hold on

for k = 1:numel(t);
    k
  
    
    for i = 1:numel(n)
        
        for j =1:numel(TV0)
            
            input(1) = n(i);
            input(6) = TV0(j);
            dT = (input(6) - (input(7) + t(k)))/input(1);
            input(8) = dT;
            y = MED(input, dT);
            output1(i, j) = y.GOR;
            output2(i, j) = y.SSA;
            
        end
        
    end
    
    figure(1);
    plot(TV0, output1);
    
    figure(2);
    plot(TV0, output2);
    
end


figure(1);
hold off
xlabel('Driving Steam Temperature');
ylabel('GOR');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');

figure(2);
hold off
xlabel('Driving Steam Temperature');
ylabel('SSA');
legend('3 effects','4 effects','5 effects','6 effects','7 effects','8 effects');