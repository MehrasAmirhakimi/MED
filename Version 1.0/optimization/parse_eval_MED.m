function y = parse_eval_MED(pop, input)

dT = 6;
ppop = size(pop, 2) *dT * pop;
n = size(pop, 1);
y = zeros(n, 1);
for i =1:n
    dT = ppop(i, :);
    output = MED(input, dT);
    y(i) = output.GOR;
end


end