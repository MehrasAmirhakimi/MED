function y = MED(input, dT)
%% solving MED equations

global n ER R P xF TV0 Tsw dTi dTc dTfric x0 U0

n = input(1);
ER = input(2);
R = input(3);
P = input(4);
xF = input(5);
TV0 = input(6);
Tsw = input(7);
dTi = dT';
dTc = input(8);
dTfric = 0.1;

if isempty(U0)
    U0 = 2500;
end

x0 = [10;10;20;30;50;500;500;100;10;70;2700;20;500;20;70;0.05;500];

if n > 1
    ix0 = [10;70;2700;20;500;20;70;0.05;500];
    for i = 2:n
        x0 = [x0;ix0];
    end
end

x00 = ones(9*(n-1)+17, 1);
options = optimoptions('fsolve','MaxIter',5000,'MaxFunEvals',100000,'TolX',1e-6,'TolFun',1e-6,'Display','iter');
[x,~] = fsolve(@eqfun,x00,options);

x = x .* x0;

%% effect heat transfer area

mdH = zeros(n+1, 1);
mdH(1) = (x(9)+x(2))*x(11) + x(14)*x(17) - x(4)*x(6);
for i = 2:n
    
    mdH(i) = x(9*(i-1)+9)*x(9*(i-1)+11) + x(9*(i-1)+14)*x(9*(i-1)+17) - x(9*(i-2)+14)*x(9*(i-2)+17);
    
end
mdH(n+1) = x(9*(n-1)+9)*(x(9*(n-1)+11) - x(7));


U = U0 * ones(n+1, 1);

A = zeros(size(mdH));
A(1:n) = mdH(1:n)./(dTi.*U(1:n));
A(n+1) = mdH(n)/(dTc*U(n+1));

%% results

GOR = P / x(1); % product to motive steam ratio

y.x = x;
y.A = A;
y.GOR = GOR;
y.SSA = sum(A)/P ;

end