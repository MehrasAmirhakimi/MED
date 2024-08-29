function dT = BPE(T, x)

x = x * 100;
a = 8.325e-2 + 1.883e-4*T + 4.02e-6*T.^2;
b = -7.625e-4 + 9.02e-5*T -5.2e-7*T.^2;
c = 1.522e-4 -3e-6*T -3e-8*T.^2;

dT = a.*x + b.*x.^2 + c.*x.^3;


end