clc
clear all

global ER R TV0 P F xF Tsw dT dTc BPE dTfric x0

ER = 1;             % Entrainment Ratio
R = 0.35;           % Recovery Ratio
TV0 = 90;           % °C
P = 5;              % kg/s
F = 20;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 20;           % °C
dT = 6;             % °C
dTc = 30;           % °C
BPE = 0.5;          % °C
dTfric = 0.5;       % °C

x0 = [3 3 6 60 2000 2000 4 70 3500 4 50 2000 10 0.02 70 2000];

x00 = ones(1, 16);
options = optimoptions('fsolve','MaxIter',500,'MaxFunEvals',10000,'TolX',1e-16,'TolFun',1e-16,'Display','iter');
[x,fval] = fsolve(@myfun8,x00,options)
sol = x.*x0;

Vm = sol(1)
Vplus = sol(2)
V0 = sol(3)
TP2 = sol(4)
HP2 = sol(5)
HP = sol(6)
V1 = sol(7)
TV1 = sol(8)
HV1 = sol(9)
D1 = sol(10)
TF = sol(11)
HF = sol(12)
W1 = sol(13)
xW1 = sol(14)
TW1 = sol(15)
HW1 = sol(16)