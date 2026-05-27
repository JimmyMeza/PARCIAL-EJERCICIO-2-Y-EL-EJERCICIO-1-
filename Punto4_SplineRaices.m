clc; clear; close all;

f = [10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
     35 37.5 40 42.5 45 47.5 50 52.5 55 57.5 ...
     60 62.5 65 67.5 70 72.5 75 77.5 80 82.5 ...
     85 87.5 90 92.5 95 97.5 100 102.5 105 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 1.482 1.551 ...
     1.216 1.048 0.866 0.689 0.521 0.364 0.223 0.103 0.012 -0.041 ...
     -0.057 -0.034 0.018 0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
     0.611 0.688 0.756 0.811 0.856 0.894 0.926 0.954 0.980 1.004];

% Intervalos donde hay cambio de signo
intervalos = [55 57.5; 62.5 65];

raiz_biseccion = zeros(2,1);
raiz_spline = zeros(2,1);

% Spline cúbico
pp = spline(f,V);
fun_spline = @(x) ppval(pp,x);

tol = 1e-6;
max_iter = 100;

for k = 1:2

    a = intervalos(k,1);
    b = intervalos(k,2);

    % Función lineal para bisección usando interpolación
    fun_bis = @(x) interp1(f,V,x,'linear');

    for i = 1:max_iter
        c = (a+b)/2;

        fa = fun_bis(a);
        fc = fun_bis(c);

        if abs(fc) < tol || (b-a)/2 < tol
            break
        end

        if fa*fc < 0
            b = c;
        else
            a = c;
        end
    end

    raiz_biseccion(k) = c;

    % Raíz usando spline
    raiz_spline(k) = fzero(fun_spline, intervalos(k,:));
end

% Tabla completa
Cruce = ["Primer cruce"; "Segundo cruce"];

tabla = table(Cruce, intervalos(:,1), intervalos(:,2), raiz_biseccion, raiz_spline, ...
    'VariableNames', {'Cruce','Inicio_kHz','Fin_kHz','Raiz_Biseccion_kHz','Raiz_Spline_kHz'});

disp(tabla);

% Gráfica
ff = linspace(50,70,1000);
VV = ppval(pp,ff);

figure
plot(f,V,'o')
hold on
plot(ff,VV,'LineWidth',1.5)
yline(0,'--')
plot(raiz_biseccion, zeros(size(raiz_biseccion)), 'x', 'MarkerSize',10,'LineWidth',2)
plot(raiz_spline, zeros(size(raiz_spline)), 's', 'MarkerSize',8,'LineWidth',2)

grid on
xlabel('Frecuencia f (kHz)')
ylabel('Voltaje V(f)')
title('Comparación de raíces por bisección y spline cúbico')
legend('Datos','Spline cúbico','Nivel cero','Bisección','Spline','Location','best')