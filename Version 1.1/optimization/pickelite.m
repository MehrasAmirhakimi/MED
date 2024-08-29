function y = pickelite(initpop, crosspop, mutpop, m)

totalpop = [initpop; crosspop; mutpop];

if m == 0;
    [~, f] = min(totalpop(:, end));
    y = totalpop(f, :);
else
    [~, f] = max(totalpop(:, end));
    y = totalpop(f, :);
end

end