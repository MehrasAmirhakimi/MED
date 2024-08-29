clc
clear all
close all


%% LMTD change effect on feed, cooling water & GOR

dT = linspace(4.5,6.5, 20);
input = [5, 1, 0.75, 50, 0.015, 70, 25, dT(1)];
output = zeros(3, numel(dT));

for i=1:numel(dT)
    
    input(8) = dT(i);
    y = MED(input, dT(i));
    output(1, i) = y.x(4);
    output(2, i) = y.x(8);
    output(3, i) = y.GOR;
    
end

plot(dT, output(1, :));
xlabel('LMTD');
ylabel('Feed Water');

figure
plot(dT, output(2, :));
xlabel('LMTD');
ylabel('Cooling Water');

figure
plot(dT, output(3, :));
xlabel('LMTD');
ylabel('GOR');

%% number of effects effect on feed, cooling water & GOR

n = 3:10;
input = [n(1), 1, 0.75, 50, 0.015, 80, 25, 5];
dT = (80 - 37)./n - 0.6;
output = zeros(12, numel(n));
results = cell(size(n));
for i=1:numel(n)
    
    input(1) = n(i);
    y = MED(input, dT(i));
    results(i) = {y.x};
    output(1, i) = y.x(4);
    output(2, i) = y.x(8);
    output(3, i) = y.GOR;
    output(4:3+n(i), i) = y.x(8*((1:n(i))-1)+10);
end

figure
plot(n, output(1, :));
xlabel('number of effects');
ylabel('Feed Water');

figure
plot(n, output(2, :));
xlabel('number of effects');
ylabel('Cooling Water');

figure
plot(n, output(3, :));
xlabel('number of effects');
ylabel('GOR');

figure
hold on
y_plot = cell(n(end), 2);
TVi = output(4:3+n(end), :);
color = {'y' 'm' 'c' 'r' 'g' 'b' 'k'};
legendTV = cell(1, n(end));
for i = 1:n(end)
    y_plot{i} = {max(n(1), i):n(end), TVi(i, (max(n(1), i):n(end))-n(1)+1)};
    plot(y_plot{i}{1}, y_plot{i}{2}, color{mod(i, numel(color))+1});
    legendTV{i} = ['TV', num2str(i)];
end
legend(legendTV);
hold off
xlabel('number of effects');
ylabel('Vapor Steam Temperaturs');