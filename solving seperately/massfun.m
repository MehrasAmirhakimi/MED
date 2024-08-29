function Fun = massfun(x)
%% known variables

global n ER R F P xF x0m

%% main equations

x = x .* x0m;

Fun = [x(1) + x(2) - x(3);          % mass TVC
       x(2) - ER*x(1);              % entrainment ratio
       P - x(4*n) - x(4*n+1);       % mass mixing product
       x(3) - x(5);                 % mass shell side
       F - x(6) - x(4) - x(2);      % mass tube side
       F*xF - x(6)*x(7);            % salinity
       R(1) * F - (F - x(6))];      % recovery ratio
   
  if n > 1
      
      for i = 2:n
          
          iFun = [x(4*i-3) + x(4*i-4) - x(4*i+1);              % mass shell side
                  x(4*i-2) - x(4*i+2) - x(4*i);                % mass tube side
                  x(4*i-2)*x(4*i-1) - x(4*i+2).*x(4*i+3);      % salinity2)
                  R(i) * x(4*i-2) - (x(4*i-2) - x(4*i+2))];    % recovery ratio
              Fun = [Fun; iFun];
      end
      
  end
end