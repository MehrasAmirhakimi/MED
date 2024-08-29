clc
clear all

%% input parameters

global ER R TV0 P F xF Tsw dT dTc BPE dTfric x0 i_var_m i_eq_m

ER = 1.5;           % Entrainment Ratio
R = 0.25;           % Recovery Ratio
TV0 = 90;           % °C
P = 6;              % kg/s
F = 20;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 20;           % °C
dT = 6;             % °C
dTc = 30;           % °C
BPE = 0.5;          % °C
dTfric = 0.5;       % °C

%% solving procedure

x0 = [3 3 6 60 2000 2000 4 70 3500 4 50 2000 10 0.02 70 2000];
% x0 = ones(1, 16);

%% mass equations
i_var_m = zeros(size(x0));
i_var_m([1 2 3 7 10 13]) = 1;

i_eq_m = zeros(1, 18);
i_eq_m([1 3 4 5 8 14]) = 1;

x0m = ones(1, sum(i_var_m));

options = optimoptions('fsolve','MaxIter',500,'MaxFunEvals',10000,'TolX',1e-16,'TolFun',1e-16,'Display','iter');
[x,fval] = fsolve(@myfun9,x0m,options)
sol = x.*x0(i_var_m == 1);

Vm = sol(1)
Vplus = sol(2)
V0 = sol(3)
V1 = sol(4)
D1 = sol(5)
W1 = sol(6)
