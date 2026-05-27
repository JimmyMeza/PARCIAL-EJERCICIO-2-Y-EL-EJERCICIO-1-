clc; clear; close all;

% Datos del intervalo donde ocurre el primer cambio de signo
f1 = 55.0;
V1 = 0.012;

f2 = 57.5;
V2 = -0.041;

% Función lineal interpolada entre los dos puntos
V_interp = @(x) V1 + (V2 - V1) * (x - f1) / (f2 - f1);

% Método de bisección
a = f1;
b = f2;
tol = 1e-6;
max_iter = 100;

for i = 1:max_iter
    c = (a + b) / 2;
    
    fa = V_interp(a);
    fc = V_interp(c);
    
    if abs(fc) < tol || (b - a)/2 < tol
        break;
    end
    
    if fa * fc < 0
        b = c;
    else
        a = c;
    end
end

fprintf('Primera raíz aproximada por bisección: %.6f kHz\n', c);
fprintf('Voltaje en la raíz: %.8f V\n', V_interp(c));
fprintf('Número de iteraciones: %d\n', i);