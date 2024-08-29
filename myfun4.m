function Fun = myfun4(x)
%% known variables

R = 1;              % Entrainment Ratio
TV0 = 120;          % °C
F = 20;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 22;           % °C
TF = 80;            % °C
P = 10;             % kg/s
dT = 6;             % °C
BPE = 0.5;          % °C
dTfric = 0.5;       % °C

%% equations measuring other known (dependant) variabes

HVm = 2800; %kJ/kg read from steam table instead of a state equation
% PV0 = 22089*exp((647.286/(TV0+273.15) - 1)*(-7.419242 + 0.29721*(0.01*(TV0+273.15-338.15)) - 0.1155286*(0.01*(TV0+273.15-338.15))^2 + 0.008685635*(0.01*(TV0+273.15-338.15))^3));
TD1 = TV0;
Hsw = FuncHsw(Tsw, xF);
HF  = FuncHsw(TF, xF);
HV0 = FuncHsatv(TV0);
HD1 = FuncHsw(TD1, 0);

%% main equations

x0 = [3 3 2500 100 5 2 2 2000 2000 10 0.02 2000 80];
x0d = diag(x0);
x = x * x0d;

Fun = [x(:, 1) + x(:, 2) - x(:, 6) ...;
      x(:, 1)*HVm + x(:, 2).*x(:, 3) - x(:, 6)*HV0 ...;
      x(:, 2) - R*x(:, 1) ...;
      x(:, 6) - x(:, 7) ...;
      F - x(:, 10) - x(:, 5) - x(:, 2) ...;
      F*xF - x(:, 10).*x(:, 11) ...;
      x(:, 6)*HV0 + F*HF - (x(:, 2)+x(:, 5)).*x(:, 3) - x(:, 7)*HD1 - x(:, 10).*x(:, 12) ...;
      P - x(:, 5) - x(:, 7) ...;
      x(:, 5).*x(:, 8) + x(:, 7)*HD1 - P*x(:, 9) ...;
      x(:, 5).*x(:, 3) + F*Hsw - x(:, 5).*x(:, 8) - F*HF ...;
      x(:, 4) - x(:, 13) + BPE + dTfric ...;
      x(:, 3) - FuncHsatv(x(:, 4)) ...;
      x(:, 12) - FuncHsw(x(:, 13), x(:, 11)) ...;
      dT * (log(TV0 - x(:, 4)) - log(TD1 - TF)) - (TV0 - x(:, 4) - TD1 + TF)];
%Fun = sum(Fun.^2, 2);
end