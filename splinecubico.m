clc; clear; close all;

% ==========================
% DATOS DEL ENSAYO
% ==========================

f = [10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
     35 37.5 40 42.5 45 47.5 50 52.5 55 57.5 ...
     60 62.5 65 67.5 70 72.5 75 77.5 80 82.5 ...
     85 87.5 90 92.5 95 97.5 100 102.5 105 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 1.482 1.551 ...
     1.216 1.048 0.866 0.689 0.521 0.364 0.223 0.103 0.012 -0.041 ...
     -0.057 -0.034 0.018 0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
     0.611 0.688 0.756 0.811 0.856 0.894 0.926 0.954 0.980 1.004];

Z = [182.4 178.9 175.1 171.0 166.8 162.7 158.9 155.4 152.0 149.0 ...
     146.1 145.2 145.8 147.3 149.9 153.5 158.0 163.2 168.9 174.8 ...
     180.5 186.2 191.5 196.2 200.1 203.1 205.2 206.3 206.1 204.7 ...
     198.0 194.4 190.9 187.8 185.1 183.0 181.6 180.8 180.6 180.9];

% Frecuencias a estimar
fp = [41 73];

% ==========================
% LAGRANGE DE SEGUNDO GRADO
% ==========================

V_lagrange = zeros(size(fp));
Z_lagrange = zeros(size(fp));

for k = 1:length(fp)

    x = fp(k);

    % Buscar los tres puntos más cercanos
    [~, orden] = sort(abs(f - x));
    idx = sort(orden(1:3));

    fx = f(idx);
    Vx = V(idx);
    Zx = Z(idx);

    % Aplicar Lagrange grado 2
    V_lagrange(k) = lagrange_grado2(fx, Vx, x);
    Z_lagrange(k) = lagrange_grado2(fx, Zx, x);

end

% ==========================
% SPLINE CÚBICO NATURAL
% ==========================

V_spline = interp1(f, V, fp, 'spline');
Z_spline = interp1(f, Z, fp, 'spline');

% ==========================
% TABLA DE RESULTADOS
% ==========================

Resultados = table(fp', V_lagrange', V_spline', Z_lagrange', Z_spline', ...
    'VariableNames', {'Frecuencia_kHz', 'V_Lagrange', 'V_Spline', 'Z_Lagrange', 'Z_Spline'});

disp(Resultados);

% ==========================
% GRÁFICAS
% ==========================

ff = linspace(min(f), max(f), 500);

VV_spline = interp1(f, V, ff, 'spline');
ZZ_spline = interp1(f, Z, ff, 'spline');

figure;
plot(f, V, 'o', ff, VV_spline, '-');
grid on;
xlabel('Frecuencia f (kHz)');
ylabel('Voltaje V (V)');
title('Interpolación spline cúbica de V(f)');

figure;
plot(f, Z, 'o', ff, ZZ_spline, '-');
grid on;
xlabel('Frecuencia f (kHz)');
ylabel('|Z| (\Omega)');
title('Interpolación spline cúbica de |Z|(f)');

% ==========================
% FUNCIÓN DE LAGRANGE
% ==========================

function y = lagrange_grado2(xp, yp, x)

    y = 0;

    for i = 1:3
        L = 1;

        for j = 1:3
            if i ~= j
                L = L * (x - xp(j)) / (xp(i) - xp(j));
            end
        end

        y = y + yp(i) * L;
    end

end