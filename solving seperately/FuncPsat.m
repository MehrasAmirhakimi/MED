function P = FuncPsat(T)

P = 22089*exp((647.286./(T+273.15) - 1).*(-7.419242 + 0.29721*(0.01*(T+273.15-338.15)) - 0.1155286*(0.01*(T+273.15-338.15)).^2 + 0.008685635*(0.01*(T+273.15-338.15)).^3));
P(T < -250) = 0;
P(T > 200) = 32.5751 * (T(T > 200) - 200) + 1.5567e+03;

end