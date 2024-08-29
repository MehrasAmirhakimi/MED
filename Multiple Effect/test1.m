%% known variables
x = x00;
global n ER R P xF TV0 Tsw BPE dT dTc dTfric x0

HV0 = FuncHsatv(TV0);
Hsw = FuncHsw(Tsw, xF);
%% main equations

x = x .* x0;
Fun = [x(1) + x(2) - x(3);                              % mass TVC
       x(2) - ER*x(1);                                  % entrainment ratio
       R * x(4) - (x(4) - x(8*(n-1)+14));               % total recovery ratio
       P - x(8*(n-1)+9) - x(8*(n-1)+12);                % mass mixing product
       x(3) - x(12);                                    % mass 1st effect (shell side)
       x(4) - x(14) - x(9) - x(2);                      % mass 1st effect (tube side)
       x(4)*xF - x(14)*x(15);                           % salinity
       x(3)*HV0 + x(4)*x(6) - (x(9)+x(2))*x(11) - x(12)*x(13) - x(14)*x(16); % energy 1st effect
       TV0 - x(10) - dT - BPE - dTfric;                 % LMTD 1st effect
       x(8*(n-1)+9)*x(8*(n-1)+11) + x(8)*Hsw - x(8*(n-1)+9)*x(7) - x(8)*x(6);   % energy condenser
       dTc*(log(x(10)-Tsw)-log(x(10)-x(5)))-(x(5)-Tsw); % LMTD condenser
       x(6) - FuncHsw(x(5),xF);                         % enthalpy correlation HF
       x(7) - FuncHsw(x(8*(n-1)+10),0);                 % enthalpy correlation HP2
       x(11) - FuncHsatv(x(10));                        % enthalpy correlation HV1
       x(13) - FuncHsw(TV0,0);                          % enthalpy correlation HD1
       x(16) - FuncHsw(x(10),x(15))];                   % enthalpy correlation HW1
   
  if n > 1
      
      for i = 2:n
          
          iFun = [x(8*(i-2)+9) + x(8*(i-2)+12) - x(8*(i-1)+12);                 % mass ist effect (shell side)
                  x(8*(i-2)+14) - x(8*(i-1)+14) - x(8*(i-1)+9);                 % mass ist effect (tube side)
                  x(8*(i-2)+14)*x(8*(i-2)+15) - x(8*(i-1)+14)*x(8*(i-1)+15);    % salinity
                  x(8*(i-2)+9)*x(8*(i-2)+11) + x(8*(i-2)+12)*x(8*(i-2)+13) + x(8*(i-2)+14)*x(8*(i-2)+16) - x(8*(i-1)+9)*x(8*(i-1)+11) - x(8*(i-1)+12)*x(8*(i-1)+13) - x(8*(i-1)+14)*x(8*(i-1)+16);  % energy ist effect
                  x(8*(i-2)+10) - x(8*(i-1)+10) - dT - BPE - dTfric;            % LMTD ist effect
                  x(8*(i-1)+11) - FuncHsatv(8*(i-1)+10);                        % enthalpy correlation HVi
                  x(8*(i-1)+13) - FuncHsw(x(8*(i-2)+10),0);                     % enthalpy correlation HDi
                  x(8*(i-1)+16) - FuncHsw(x(8*(i-1)+10),x(8*(i-1)+15))];        % enthalpy correlation HWi
              Fun = [Fun; iFun];
      end
      
  end