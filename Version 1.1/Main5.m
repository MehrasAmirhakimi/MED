clc
clear all
close all

%% solving equations

global n ER R P xF TV0 Tsw BPE dT dTc dTfric x0

n = 5;
ER = 1;
R = 0.75;
P = 50;
xF = 0.015;
TV0 = 60;
Tsw = 25;
dT = 4;
dTc = 6;
BPE = 0.5;
dTfric = 0.1;

x0 = [10;10;20;30;50;500;500;100;10;70;2700;20;500;20;0.05;500];

if n > 1
    for i = 2:n
        ix0 = [10;70;2700;20;500;20;0.05;500];
        x0 = [x0;ix0];
    end
end

x00 = ones(8*(n-1)+16, 1);
options = optimoptions('fsolve','MaxIter',5000,'MaxFunEvals',100000,'TolX',1e-6,'TolFun',1e-6,'Display','off');
[x,fval] = fsolve(@eqfun,x00,options);

x = x .* x0;

%% effect heat transfer area
landa = zeros(n+1, 1);
landa(1) = (x(9)+x(2))*x(11) + x(14)*x(16) - x(4)*x(6);

for i = 2:n
    
    landa(i) = x(8*(i-1)+9)*x(8*(i-1)+11) + x(8*(i-1)+14)*x(8*(i-1)+16) - x(8*(i-2)+14)*x(8*(i-2)+16);
    
end

landa(n+1) = x(8*(n-1)+9)*(x(8*(n-1)+11) - x(7));

%% showing results

GOR = P / x(1); % product to motive steam ratio

fprintf('Vm = %g\nVplus = %g\nV0 = %g\nF = %g\nTF = %g\nMcw = %g\nGOR = %g\n', x(1), x(2), x(3), x(4), x(5), x(8), GOR);

for i = 1:n
    
    fprintf('\nV%g = %g \n', i, x(8*(i-1)+9));
    fprintf('TV%g = %g \n', i, x(8*(i-1)+10));
    fprintf('D%g = %g \n', i, x(8*(i-1)+12));
    fprintf('W%g = %g \n', i, x(8*(i-1)+14));
    fprintf('xW%g = %g \n', i, x(8*(i-1)+15));
    
    if i == 1
        fprintf('R%g = %g \n', i, (x(4)-x(8*(i-1)+14))/x(4));
    else
        fprintf('R%g = %g \n', i, (x(8*(i-2)+14)-x(8*(i-1)+14))/x(8*(i-2)+14));
    end
    
end