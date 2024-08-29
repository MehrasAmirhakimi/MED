clc
clear all
close all

Tsw = 25;

TF_array = linspace(30, 40, 50);
dT_array = linspace(1, 10, 50);
[TF_mesh, dT_mesh] = meshgrid(TF_array, dT_array);

z = (Tsw - TF_mesh) ./ (exp((Tsw - TF_mesh)./dT_mesh) - 1);
[n, m] = size(TF_mesh);

surf(TF_mesh, dT_mesh, z);
xlabel('TF');
ylabel('dT');
zlabel('TVn - Tsw');