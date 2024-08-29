function y = realmutation(x, mu, id)

if mu == 0
    nm = 1;
else
    nm = ceil(mu * numel(x));
end

mp = randsample(numel(x), nm)';

y = x;
y(mp) = rand(1, nm) .* (id(2, mp) - id(1, mp)) + id(1, mp);

y = min(y, id(2, :));
y = max(y, id(1, :));

y = y/sum(y);

end