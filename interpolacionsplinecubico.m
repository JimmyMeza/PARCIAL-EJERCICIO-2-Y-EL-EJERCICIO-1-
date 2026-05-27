clc; clear; close all;
datos_ensayo;

puntos = [41 73];

V_lagrange = zeros(size(puntos));
Z_lagrange = zeros(size(puntos));

for i = 1:length(puntos)
    x = puntos(i);

    [~, idx] = sort(abs(f - x));
    idx = sort(idx(1:3));

    fx = f(idx);
    Vx = V(idx);
    Zx = Z(idx);

    V_lagrange(i) = lagrange2(fx, Vx, x);
    Z_lagrange(i) = lagrange2(fx, Zx, x);
end

V_spline = spline(f, V, puntos);
Z_spline = spline(f, Z, puntos);

tabla_resultados = table(puntos', V_lagrange', V_spline', Z_lagrange', Z_spline', ...
    'VariableNames', {'f_kHz','V_Lagrange','V_Spline','Z_Lagrange','Z_Spline'});

disp(tabla_resultados);

ff = linspace(min(f), max(f), 500);
VV = spline(f, V, ff);
ZZ = spline(f, Z, ff);

figure;
plot(f, V, 'o', ff, VV, '-');
grid on;
xlabel('Frecuencia f (kHz)');
ylabel('Voltaje V (V)');
title('Spline cúbico para V(f)');

figure;
plot(f, Z, 'o', ff, ZZ, '-');
grid on;
xlabel('Frecuencia f (kHz)');
ylabel('|Z| (\Omega)');
title('Spline cúbico para |Z|(f)');

function y = lagrange2(xp, yp, x)
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