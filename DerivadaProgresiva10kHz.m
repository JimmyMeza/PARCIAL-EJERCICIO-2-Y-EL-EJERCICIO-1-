clc; clear; close all;

f = [10 12.5 15];
V = [0.842 0.911 0.986];

h = 2.5;

derivada_10 = (-3*V(1) + 4*V(2) - V(3)) / (2*h);

fprintf('dV/df en 10 kHz = %.6f V/kHz\n', derivada_10);