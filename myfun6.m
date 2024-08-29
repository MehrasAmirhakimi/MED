function Fun = myfun6(x)
%% known variables

global ER R TV0 F xF Tsw dT dTc BPE dTfric x0

%% equations measuring other known (dependant) variabes

HVm = 1700; %kJ/kg read from steam table instead of a state equation
% PV0 = 22089*exp((647.286/(TV0+273.15) - 1)*(-7.419242 + 0.29721*(0.01*(TV0+273.15-338.15)) - 0.1155286*(0.01*(TV0+273.15-338.15))^2 + 0.008685635*(0.01*(TV0+273.15-338.15))^3));
TD1 = TV0;
Hsw = FuncHsw(Tsw, xF);
HV0 = FuncHsatv(TV0);
HD1 = FuncHsw(TD1, 0);

%% main equations


x0d = diag(x0);
x = x * x0d;

Fun = [x(:, 1) + x(:, 2) - x(:, 3) ...;
      x(:, 1)*HVm + x(:, 2).*x(:, 10) - x(:, 3)*HV0 ...;
      x(:, 2) - ER*x(:, 1) ...;
      x(:, 3) - x(:, 11) ...;
      F - x(:, 14) - x(:, 8) - x(:, 2) ...;
      F*xF - x(:, 14).*x(:, 15) ...;
      x(:, 3)*HV0 + F*x(:, 13) - (x(:, 2)+x(:, 8)).*x(:, 10) - x(:, 11)*HD1 - x(:, 14).*x(:, 17) ...;
      x(:, 6) - x(:, 8) - x(:, 11) ...;
      x(:, 8).*x(:, 5) + x(:, 11)*HD1 - x(:, 6)*x(:, 7) ...;
      x(:, 8).*x(:, 10) + F*Hsw - x(:, 8).*x(:, 5) - F*x(:, 13) ...;
      x(:, 9) - x(:, 16) ...;
      TV0 - x(:, 9) - dT - dTfric - BPE ...;
      x(:, 9) - x(:, 12) - dTc ...;
      R * F - (F - x(:, 14)) ...;
      x(:, 13) - FuncHsw(x(:, 12), xF) ...;
      x(:, 10) - FuncHsatv(x(:, 9)) ...;
      x(:, 17) - FuncHsw(x(:, 16), x(:, 15)) ...;
      x(:, 5) - FuncHsw(x(:, 4), 0)];
end