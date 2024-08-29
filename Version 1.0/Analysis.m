clc
clear all
close all


%% input parameters

global U0

n = 6;
ER = 1.5;
R = 0.75;
P = 35;
xF = 0.035;
TV0 = 70;
Tsw = 25;
dT = 5;
U0 = 2;

input = [n, ER, R, P, xF, TV0, Tsw, dT];
y = MED(input, dT);


%% results

x = y.x;

% Feed and Cooling Water flow rate and Temperature (kg/s)
F = x(4)
Mcw = x(8)
TF = x(5)

% motive, suction and driving steam flow rate (kg/s)
Vm = x(1)
Vplus = x(2)
V0 = x(3)

% Steam Flow rates
V = x(8*((1:n)-1)+9)

% Distillata flow rates
D = x(8*((1:n)-1)+12)

% Brine flow rates (kg/s)
W = x(8*((1:n)-1)+14)

% Steam Temperatures
TV =  x(8*((1:n)-1)+10)

% outlet flow concentrations (g/g)
x_F = x(8*((1:n)-1)+15)


% Heat transfer surface (m^2)
A = y.A

% Recovery
W1 = zeros(size(W));
W1(1) = F;
W1(2:n) = W(1:n-1);
R = (W1-W)/F

% GOR and SHTA
GOR = y.GOR
SHSA = y.SSA

%% plotting results

% Flow Rates
plot(1:n, V, '-*',...
    1:n, D, '-s',...
    1:n, W, '-^',...
    1:n, ones(n, 1)*P, 'k', 'LineWidth',1.25)
axis([1 n 0 1.2*P])
legend('Vapor', 'Distilled Water','Saline Water',...
    'Orientation', 'horizontal','Location','North')
xlabel('Effect Number')
ylabel('Flow Rate [kg/s]')

% Concentration
figure
plot(1:n, ones(n, 1)*xF, 'k', 1:n, x_F, 'LineWidth',1.25)
ylim([0, 0.16])
xlabel('Effect Number')
ylabel('Concentration [kg/kg]')

% Recovery Ratio
figure
plot(1:n, R, 'LineWidth',1.25)
ylim([0, 1.1*max(R)])
xlabel('Effect Number')
ylabel('Recovery Ratio')

% Heat Transfer Surface Area
figure
plot(1:n, A(1:n), 'LineWidth',1.25)
xlabel('Effect Number')
ylabel('Heat Transfer Surface Area [m^2]')
axis([1 n 0 1.1*max(A(1:n))])