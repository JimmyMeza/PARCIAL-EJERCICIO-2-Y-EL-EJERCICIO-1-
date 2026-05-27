clc; clear; close all;

f1 = 62.5;
V1 = -0.034;

f2 = 65.0;
V2 = 0.018;

V_interp = @(x) V1 + (V2-V1)*(x-f1)/(f2-f1);

a = f1;
b = f2;

tol = 1e-6;
max_iter = 100;

for i = 1:max_iter

    c = (a+b)/2;

    fa = V_interp(a);
    fc = V_interp(c);

    if abs(fc) < tol || (b-a)/2 < tol
        break
    end

    if fa*fc < 0
        b = c;
    else
        a = c;
    end

end

fprintf('Segunda raiz = %.6f kHz\n',c);