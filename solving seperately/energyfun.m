function Fun = energyfun(x)
%% known variables

global n Cr HVm TV0 F P Tsw xF BPE dTfric xm x0e

%% equations measuring other known (dependant) variabes

Hsw = FuncHsw(Tsw, xF);
HV0 = FuncHsatv(TV0);

%% main equations


x = x .* x0e;

Fun = [xm(3)*HV0 + F*x(2) - (xm(4)+xm(2))*x(6) - xm(5)*x(8) - xm(6)*x(10);
       xm(4*n)*x(6*n) + F*Hsw - xm(4*n)*x(4) - F*x(2);
       Cr * FuncPsat(x(5)) - FuncPsat(TV0);
       x(5) - x(9) + BPE + dTfric;
       x(7) - TV0;
       x(2) - FuncHsw(x(1), xF);
       x(4) - FuncHsw(x(3), 0);
       x(6) - FuncHsatv(x(5));
       x(8) - FuncHsw(x(7), 0);
       x(10) - FuncHsw(x(9), xm(7))];
   
   if n > 1

      for i = 2:n
          
         iFun =  [xm(4*i-4)*x(6*i-6) + xm(4*i-2)*x(6*i-2) - xm(4*i)*x(6*i) - xm(4*i+1)*x(6*i+2) - xm(4*i+2)*x(6*i+4);
                  x(6*i-1) - x(6*i+3) + BPE + dTfric;
                  x(6*i+1) - x(6*i-7);
                  x(6*i) - FuncHsatv(x(6*i-1));
                  x(6*i+2) - FuncHsw(x(6*i+1), 0);
                  x(6*i+4) - FuncHsw(x(6*i+3), xm(4*i+3))];
              Fun = [Fun; iFun];
      end
  
   end
end