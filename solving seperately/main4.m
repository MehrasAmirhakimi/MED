clc
clear all
close all
%% mass

global n ER R F P xF x0m xm

R = [0.15 0.15];
%R = 0.3;
n = 2;
%n = 1;
ER = 1;
F = 20;
P = 5;
%P = 8.84;
xF = 0.015;
x0m = 10 * ones(4*n+3, 1);
%x0m = 10 * ones(7, 1);

options = optimoptions('fsolve','MaxIter',500,'MaxFunEvals',10000,'TolX',1e-6,'TolFun',1e-6,'Display','iter');
[xm,fvalm] = fsolve(@massfun,x0m,options);

xm = xm .* x0m

%% energy

global Cr HVm TV0 Tsw BPE dTfric x0e

Cr = 1.25;
HVm = 2000;
TV0 = 70;
Tsw = 25;
BPE = 0.5;
dTfric = 0.5;
x0e = repmat([70; 2000], [3*n+2, 1]);

options = optimoptions('fsolve','MaxIter',500,'MaxFunEvals',10000,'TolX',1e-6,'TolFun',1e-6,'Display','iter');
[xe,fvale] = fsolve(@energyfun,x0e,options);

xe = xe .* x0e

TV1 = xe(5)
TV2 = xe(6*2-1)
%TV3 = xe(6*3-1)

dT1 = TV0 - xe(9)
dT2 = xe(6*2-7) - xe(6*2+3)
%dT3 = xe(6*3-7) - xe(6*3+3)
dTc = (Tsw - xe(1))/log((xe(5)-xe(1))/(xe(5)-Tsw))