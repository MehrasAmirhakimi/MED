clc
clear all

global n R TV0 F xF Tsw TF P dT BPE dTfric x0

n = 3;              % number of effects
R = 1;              % Entrainment Ratio
TV0 = 120;          % °C
F = 20;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 22;           % °C
TF = 50;            % °C
P = 10;             % kg/s
dT = 6;             % °C
BPE = 0.5;          % °C
dTfric = 0.5;       % °C

x0 = [3 3 2 2000 2000 5 100 2500 2 10 0.02 80 2000];

x00 = ones(1, 13);
options = optimoptions('fsolve','MaxFunEvals',2000,'TolX',1e-10,'TolFun',1e-10,'Display','iter');
[x,fval] = fsolve(@myfun5,x00,options)
mat2str(x.*x0)