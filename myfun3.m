function Fun = myfun3(x)
%% known variables

TV0 = 125;          % �C
F = 25;             % kg/s
xF = 14.781*1e-3;   % kg/kg of solution
Tsw = 22;           % �C
P = 9;              % kg/s
dT = 6;             % �C
BPE = 0.5;          % �C
dTfric = 0.5;       % �C

%% equations measuring other known (dependant) variables

HVm = 2890; %kJ/kg read from steam table instead of a state equation
% PV0 = 22089*exp((647.286/(TV0+273.15) - 1)*(-7.419242 + 0.29721*(0.01*(TV0+273.15-338.15)) - 0.1155286*(0.01*(TV0+273.15-338.15))^2 + 0.008685635*(0.01*(TV0+273.15-338.15))^3));
TD1 = TV0;
Hsw = -0.033635409 + 4.207557011*Tsw - 6.200339e-4*Tsw^2 + 4.459374e-6*Tsw^3 - 1e-3*xF*(-2.348e4 + 3.152e5*xF + 2.308e6*xF^2 - 1.446e7*xF^3 + 7.826e3*Tsw - 4.417e1*Tsw^2 + 2.139e-1*Tsw^3 - 1.991e4*xF*Tsw + 2.778e4*xF^2*Tsw + 9.728e1*xF*Tsw^2);
HV0 = 2501.689845 + 1.806916015*TV0 + 5.087717e-4*TV0^2 - 1.1221e-5*TV0^3;
HD1 = -0.033635409 + 4.207557011*TD1 - 6.200339e-4*TD1^2 + 4.459374e-6*TD1^3;

%% main equations

x0 = [1 1 2500 100 5 2 2 2000 2000 10 0.02 2000 80 40 1500];

Fun = [x0(1)*x(1) + x0(2)*x(2) - x0(6)*x(6);
      x0(1)*x(1)*HVm + x0(2)*x(2)*x0(3)*x(3) - x0(6)*x(6)*HV0;
      x0(2)*x(2) - x0(1)*x(1);
      x0(6)*x(6) - x0(7)*x(7);
      F - x0(10)*x(10) - x0(5)*x(5) - x0(2)*x(2);
      F*xF - x0(10)*x(10)*x0(11)*x(11);
      x0(6)*x(6)*HV0 + F*x0(15)*x(15) - (x0(2)*x(2)+x0(5)*x(5))*x0(3)*x(3) - x0(7)*x(7)*HD1 - x0(10)*x(10)*x0(12)*x(12);
      P - x0(5)*x(5) - x0(7)*x(7);
      x0(5)*x(5)*x0(8)*x(8) + x0(7)*x(7)*HD1 - P*x0(9)*x(9);
      x0(5)*x(5)*x0(3)*x(3) + F*Hsw - x0(5)*x(5)*x0(8)*x(8) - F*x0(15)*x(15);
      x0(4)*x(4) - x0(13)*x(13) + BPE + dTfric;
      x0(3)*x(3) - 2501.689845 - 1.806916015*x0(4)*x(4) - 5.087717e-4*(x0(4)*x(4))^2 + 1.1221e-5*(x0(4)*x(4))^3;
      x0(12)*x(12) + 0.033635409 - 4.207557011*x0(13)*x(13) + 6.200339e-4*(x0(13)*x(13))^2 - 4.459374e-6*(x0(13)*x(13))^3 + 1e-3*(x0(11)*x(11))*(-2.348e4 + 3.152e5*x0(11)*x(11) + 2.308e6*(x0(11)*x(11))^2 - 1.446e7*(x0(11)*x(11))^3 + 7.826e3*x0(13)*x(13) - 4.417e1*(x0(13)*x(13))^2 + 2.139e-1*(x0(13)*x(13))^3 - 1.991e4*(x0(11)*x(11)*x0(13)*x(13)) + 2.778e4*(x0(11)*x(11))^2*x0(13)*x(13) + 9.728e1*x0(11)*x(11)*(x0(13)*x(13))^2);
      dT * (log(TV0 - x0(4)*x(4)) - log(TD1 - x0(14)*x(14))) - (TV0 - x0(4)*x(4) - TD1 + x0(14)*x(14));
      x0(15)*x(15) + 0.033635409 - 4.207557011*x0(14)*x(14) + 6.200339e-4*(x0(14)*x(14))^2 - 4.459374e-6*(x0(14)*x(14))^3 + 1e-3*xF*(-2.348e4 + 3.152e5*xF + 2.308e6*xF^2 - 1.446e7*xF^3 + 7.826e3*x0(14)*x(14) - 4.417e1 * (x0(14)*x(14))^2 + 2.139e-1*(x0(14)*x(14))^3 - 1.991e4*xF*x0(14)*x(14) + 2.778e4*xF^2*x0(14)*x(14) + 9.728e1*xF*(x0(14)*x(14))^2);
      % log(PV1/22089) - (647.286/(x(4)+273.15) - 1)*(-7.419242 + 0.29721*(0.01*(x(4)+273.15-338.15)) - 0.1155286*(0.01*(x(4)+273.15-338.15))^2 + 0.008685635*(0.01*(x(4)+273.15-338.15))^3);
      ];
end