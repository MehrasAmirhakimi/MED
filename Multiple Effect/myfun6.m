function Fun = myfun6(x)
%% known variables

global R TV0 F xF Tsw TF P dT BPE dTfric

%% equations measuring other known (dependant) variabes

HVm = 2800; %kJ/kg read from steam table instead of a state equation
% PV0 = 22089*exp((647.286/(TV0+273.15) - 1)*(-7.419242 + 0.29721*(0.01*(TV0+273.15-338.15)) - 0.1155286*(0.01*(TV0+273.15-338.15))^2 + 0.008685635*(0.01*(TV0+273.15-338.15))^3));
TD1 = TV0;
Hsw = FuncHsw(Tsw, xF);
HF  = FuncHsw(TF, xF);
HV0 = FuncHsatv(TV0);
HD1 = FuncHsw(TD1, 0);

%% main equations

global x0
x0d = diag(x0);
x = x * x0d;
Fun = [x(:, 1) + x(:, 2) - x(:, 3) ...;
      x(:, 1)*HVm + x(:, 2).*x(:, 6) - x(:, 3)*HV0 ...;
      x(:, 2) - R*x(:, 1) ...;
      x(:, 3) - x(:, 7) ...;
      F - x(:, 10) - x(:, 4) - x(:, 2) ...;
      F*xF - x(:, 10).*x(:, 11) ...;
      x(:, 3)*HV0 + F*HF - (x(:, 2)+x(:, 4)).*x(:, 6) - x(:, 7)*HD1 - x(:, 10).*x(:, 13) ...;
      P - x(:, 4) - x(:, 7) ...;
      x(:, 4).*x(:, 8) + x(:, 7)*HD1 - P*x(:, 9) ...;
      x(:, 4).*x(:, 6) + F*Hsw - x(:, 4).*x(:, 8) - F*HF ...;
      x(:, 5) - x(:, 12) + BPE + dTfric ...;
      x(:, 6) - FuncHsatv(x(:, 5)) ...;
      x(:, 13) - FuncHsw(x(:, 12), x(:, 11)) ...;
      dT * (log(TV0 - x(:, 5)) - log(TD1 - TF)) - (TV0 - x(:, 5) - TD1 + TF)];
%Fun = sum(Fun.^2, 2);
end