function y = MED(input)
%% solving MED equations

global n ER R P xF TV0 Tsw TF BPE dTfric x0 U0

n = input(1);
ER = input(2);
R = input(3);
P = input(4);
xF = input(5);
TV0 = input(6);
Tsw = input(7);
TF = input(8);

BPE = 0.5;
dTfric = 0.1;

if isempty(U0)
    U0 = 2.5;
end

x0 = [10;10;20;30;6;500;100;10;70;2700;20;500;20;0.05;500];

if n > 1
    ix0 = [10;70;2700;20;500;20;0.05;500];
    for i = 2:n
        x0 = [x0;ix0];
    end
end

x00 = ones(8*(n-1)+15, 1);
options = optimoptions('fsolve','MaxIter',5000,'MaxFunEvals',100000,'TolX',1e-6,'TolFun',1e-6,'Display','off');
[x,~] = fsolve(@eqfun,x00,options);

x = x .* x0;

%% effect heat transfer area

mdH = zeros(n+1, 1);
mdH(1) = (x(8)+x(2))*x(10) + x(13)*x(15) - x(4)*FuncHsw(TF, xF);
for i = 2:n
    
    mdH(i) = x(8*(i-1)+8)*x(8*(i-1)+10) + x(8*(i-1)+13)*x(8*(i-1)+15) - x(8*(i-2)+13)*x(8*(i-2)+15);
    
end
mdH(n+1) = x(8*(n-1)+8)*(x(8*(n-1)+10) - x(6));


U = U0 * ones(n+1, 1);

A = zeros(size(mdH));
A(1:n+1) = mdH(1:n+1)./(x(5)*U(1:n+1));

%% results

GOR = P / x(1); % product to motive steam ratio

y.x = x;
y.A = A;
y.GOR = GOR;
y.SSA = sum(A)/P ;

end