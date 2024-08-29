function f = RastRigin(ppop, A, B)

% global NFE
% NFE = NFE + 1;

n = size(ppop, 2);
f = A*n + sum(B * ppop.^2 - A*cos(2*pi*ppop), 2);

end