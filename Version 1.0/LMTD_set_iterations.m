clc
clear all
close all

dT(1) = 6.5;
i = 1;
input = [6, 1, 0.75, 50, 0.015, 70, 25, dT(i)];
fun = @(x) (input(7)-x)/(exp((input(7)-x)/dT(i)) - 1);
diff = 1;
while diff > 1e-1
    
    y = MED(input, dT(i));
    TF = y.x(5);
    i = i+1;
    dT(i) = (input(6)-input(7)-input(1)*0.6-fun(TF))/input(1);
    diff = abs(dT(end) - dT(end-1));
    input(8) = dT(i);
    
end