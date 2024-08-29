function Fun = eqfun(x)
%% known variables

global n ER R P xF TV0 Tsw BPE TF dTfric x0

HV0 = FuncHsatv(TV0);
Hsw = FuncHsw(Tsw, xF);
HF = FuncHsw(TF, xF);
%% main equations

x = x .* x0;
Fun = [x(1) + x(2) - x(3);                              % mass TVC
       x(2) - ER*x(1);                                  % entrainment ratio
       R * x(4) - (x(4) - x(8*(n-1)+14));               % total recovery ratio
       P - x(8*(n-1)+8) - x(8*(n-1)+11);                % mass mixing product
       x(3) - x(11);                                    % mass 1st effect (shell side)
       x(4) - x(13) - x(8) - x(2);                      % mass 1st effect (tube side)
       x(4)*xF - x(13)*x(14);                           % salinity
       x(3)*HV0 + x(4)*HF - (x(8)+x(2))*x(10) ...
       - x(11)*x(12) - x(13)*x(15);                     % energy 1st effect
       TV0 - x(9) - x(5) - BPE - dTfric;                 % LMTD 1st effect
       x(8*(n-1)+8)*x(8*(n-1)+10) ...
       + x(7)*Hsw - x(8*(n-1)+8)*x(6) - x(7)*HF;      % energy condenser 
       x(5) - (TF - Tsw)/log((x(8*(n-1)+9) - Tsw) ...
       /(x(8*(n-1)+9) - TF));                        % LMTD condenser
       x(6) - FuncHsw(x(8*(n-1)+9),0);                 % enthalpy correlation HP2
       x(10) - FuncHsatv(x(9));                        % enthalpy correlation HV1
       x(12) - FuncHsw(TV0,0);                          % enthalpy correlation HD1
       x(15) - FuncHsw(x(9)+BPE,x(14))];                   % enthalpy correlation HW1
   
  if n > 1
      
      for i = 2:n
          
          iFun = [x(8*(i-2)+8) + x(8*(i-2)+11) - x(8*(i-1)+11);                 % mass ist effect (shell side)
                  x(8*(i-2)+13) - x(8*(i-1)+13) - x(8*(i-1)+8);                 % mass ist effect (tube side)
                  x(8*(i-2)+13)*x(8*(i-2)+14) - x(8*(i-1)+13)*x(8*(i-1)+14);    % salinity
                  x(8*(i-2)+8)*x(8*(i-2)+10) + x(8*(i-2)+11)*x(8*(i-2)+12) ...
                  + x(8*(i-2)+13)*x(8*(i-2)+15) - x(8*(i-1)+8)*x(8*(i-1)+10) ...
                  - x(8*(i-1)+11)*x(8*(i-1)+12) - x(8*(i-1)+13)*x(8*(i-1)+15);  % energy ist effect
                  x(8*(i-2)+9) - x(8*(i-1)+9) - x(5) - BPE - dTfric;            % LMTD ist effect
                  x(8*(i-1)+10) - FuncHsatv(8*(i-1)+9);                        % enthalpy correlation HVi
                  x(8*(i-1)+12) - FuncHsw(x(8*(i-2)+9),0);                     % enthalpy correlation HDi
                  x(8*(i-1)+15) - FuncHsw(x(8*(i-1)+9)+BPE,x(8*(i-1)+14))];        % enthalpy correlation HWi
              Fun = [Fun; iFun];
      end
      
  end
end