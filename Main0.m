clc
clear all

x0 = [3 3 2500 100 5 2 2 2000 2000 10 0.02 2000 80];

x00 = ones(1, 13);
options = optimoptions('fsolve','MaxFunEvals',2000,'TolX',1e-10,'TolFun',1e-10,'Display','iter');
[x,fval] = fsolve(@myfun4,x00,options);
mat2str(x.*x0)