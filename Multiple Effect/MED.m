function y = MED(input)
%% solving MED equations

global n ER R P xF TV0 Tsw BPE dT dTc dTfric x0

n = input(1);
ER = input(2);
R = input(3);
P = input(4);
xF = input(5);
TV0 = input(6);
Tsw = input(7);
dT = input(8);
dTc = input(9);
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
options = optimoptions('fsolve','MaxIter',5000,'MaxFunEvals',100000,'TolX',1e-6,'TolFun',1e-6);
[x,~] = fsolve(@eqfun,x00,options);

x = x .* x0;

%% effect heat transfer area
landa = zeros(n+1, 1);
landa(1) = (x(9)+x(2))*x(11) + x(14)*x(16) - x(4)*x(6);

for i = 2:n
    
    landa(i) = x(8*(i-1)+9)*x(8*(i-1)+11) + x(8*(i-1)+14)*x(8*(i-1)+16) - x(8*(i-2)+14)*x(8*(i-2)+16);
    
end

landa(n+1) = x(8*(n-1)+9)*(x(8*(n-1)+11) - x(7));

%% results

GOR = P / x(1); % product to motive steam ratio

y = GOR;

end