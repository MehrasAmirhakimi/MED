function p = roulettewheel(cost, m)

%if m == 0
%    f = (1./cost)/sum(1./cost);
%else
%    f = cost/sum(cost);
%end

cost = - cost;

b = 5;
wc = max(cost);
f = exp(-b*cost/wc) ./ sum(exp(-b*cost/wc));

cumf = cumsum(f);
r = rand;
p = find(r <= cumf, 1, 'first');

end