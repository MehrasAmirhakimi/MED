function pop = createrandomsolution (npop, id)

nvar = size(id, 2);

pop = rand(npop, nvar);
pop = pop ./ repmat(sum(pop, 2), [1 nvar]);

end