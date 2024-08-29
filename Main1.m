clc
clear all

global ER R TV0 F xF Tsw dT dTc BPE dTfric x0

ER = 1;             % Entrainment Ratio
R = 0.3;            % Recovery Ratio
TV0 = 70;           % °C
F = 20;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 33;           % °C
dT = 6;             % °C
dTc = 20;           % °C
BPE = 0.5;          % °C
dTfric = 0.5;       % °C

x0 = [3 3 6 60 2000 10 2000 4 70 3500 4 50 2000 10 0.02 70 2000];

x00 = ones(1, 17);
options = optimoptions('fsolve','MaxIter',500,'MaxFunEvals',10000,'TolX',1e-16,'TolFun',1e-16,'Display','iter');
[x,fval] = fsolve(@myfun6,x00,options)
sol = x.*x0;

Vm = sol(1)
Vplus = sol(2)
V0 = sol(3)
TP2 = sol(4)
HP2 = sol(5)
P = sol(6)
HP = sol(7)
V1 = sol(8)
TV1 = sol(9)
HV1 = sol(10)
D1 = sol(11)
TF = sol(12)
HF = sol(13)
W1 = sol(14)
xW1 = sol(15)
TW1 = sol(16)
HW1 = sol(17)