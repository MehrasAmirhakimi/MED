function [y1, y2] = realcrossover (x1, x2, landa, id)
m = rand * (1 + landa - (-landa)) - landa;
y1 = m * x1 + (1-m) * x2;
y2 = m * x2 + (1-m) * x1;

y1 = min(y1, id(2, :));
y1 = max(y1, id(1, :));
y2 = min(y2, id(2, :));
y2 = max(y2, id(1, :));

y1 = y1/sum(y1);
y2 = y2/sum(y2);
end