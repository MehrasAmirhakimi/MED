function Fun = myfun9(x)
%% known variables

global ER R TV0 F P xF Tsw dT dTc BPE dTfric x0 i_var_m i_eq_m

%% equations measuring other known (dependant) variabes

HVm = 1700; %kJ/kg read from steam table instead of a state equation
% PV0 = 22089*exp((647.286/(TV0+273.15) - 1)*(-7.419242 + 0.29721*(0.01*(TV0+273.15-338.15)) - 0.1155286*(0.01*(TV0+273.15-338.15))^2 + 0.008685635*(0.01*(TV0+273.15-338.15))^3));
TD1 = TV0;
Hsw = FuncHsw(Tsw, xF);
HV0 = FuncHsatv(TV0);
HD1 = FuncHsw(TD1, 0);

%% main equations

x0d = diag(x0(i_var_m == 1));
x = x * x0d;

x02d = diag(x0);
x2 = ones(size(x0)) * x02d;
x2(:, i_var_m == 1) = x;

x = x2;

Fun = [x(:, 1) + x(:, 2) - x(:, 3) ...;
      x(:, 1)*HVm + x(:, 2).*x(:, 9) - x(:, 3)*HV0 ...;
      x(:, 2) - ER*x(:, 1) ...;
      x(:, 3) - x(:, 10) ...;
      F - x(:, 13) - x(:, 7) - x(:, 2) ...;
      F*xF - x(:, 13).*x(:, 14) ...;
      x(:, 3)*HV0 + F*x(:, 12) - (x(:, 2)+x(:, 7)).*x(:, 9) - x(:, 10)*HD1 - x(:, 13).*x(:, 16) ...;
      P - x(:, 7) - x(:, 10) ...;
      x(:, 7).*x(:, 5) + x(:, 10)*HD1 - P*x(:, 6) ...;
      x(:, 7).*x(:, 9) + F*Hsw - x(:, 7).*x(:, 5) - F*x(:, 12) ...;
      x(:, 8) - x(:, 15) ...;
      TV0 - x(:, 8) - dT - dTfric - BPE ...;
      x(:, 8) - x(:, 11) - dTc ...;
      R * F - (F - x(:, 13)) ...;
      x(:, 12) - FuncHsw(x(:, 11), xF) ...;
      x(:, 9) - FuncHsatv(x(:, 8)) ...;
      x(:, 16) - FuncHsw(x(:, 15), x(:, 14)) ...;
      x(:, 5) - FuncHsw(x(:, 4), 0)];
  
  Fun = Fun(:, i_eq_m == 1);
  
end