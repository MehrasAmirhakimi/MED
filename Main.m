clc
clear all

global R TV0 F xF Tsw TF P dT BPE dTfric x0

R = 1;              % Entrainment Ratio
TV0 = 70;          % °C
F = 30;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 22;           % °C
TF = 45;            % °C
P = 10;             % kg/s
dT = 6;             % °C
BPE = 0.5;          % °C
dTfric = 0.5;       % °C

x0 = [3 3 2 2000 2000 5 100 2500 2 10 0.02 80 2000];

x00 = ones(1, 13);
options = optimoptions('fsolve','MaxFunEvals',2000,'TolX',1e-10,'TolFun',1e-10,'Display','iter');
[x,fval] = fsolve(@myfun5,x00,options);
sol = real(x.*x0)';

Vm = sol(1)
Vplus = sol(2)
V0 = sol(3)
HP2 = sol(4)
HP = sol(5)
V1 = sol(6)
TV1 = sol(7)
HV1 = sol(8)
D1 = sol(9)
W1 = sol(10)
xW1 = sol(11)
TW1 = sol(12)
HW1 = sol(13)