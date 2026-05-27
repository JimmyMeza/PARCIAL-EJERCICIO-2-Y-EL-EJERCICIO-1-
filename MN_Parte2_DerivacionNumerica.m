clc; clear; close all;

f = [10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
     35 37.5 40 42.5 45 47.5 50 52.5 55 57.5 ...
     60 62.5 65 67.5 70 72.5 75 77.5 80 82.5 ...
     85 87.5 90 92.5 95 97.5 100 102.5 105 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 1.482 1.551 ...
     1.216 1.048 0.866 0.689 0.521 0.364 0.223 0.103 0.012 -0.041 ...
     -0.057 -0.034 0.018 0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
     0.611 0.688 0.756 0.811 0.856 0.894 0.926 0.954 0.980 1.004];

h = 2.5;

puntos = [40 70 100];

orden2 = zeros(size(puntos));
orden4 = zeros(size(puntos));

for i = 1:length(puntos)

    x = puntos(i);
    idx = find(f == x);

    % Diferencia centrada de orden 2
    orden2(i) = (V(idx+1) - V(idx-1)) / (2*h);

    % Diferencia centrada de orden 4
    orden4(i) = (-V(idx+2) + 8*V(idx+1) - 8*V(idx-1) + V(idx-2)) / (12*h);

end

tabla_punto1 = table(puntos', orden2', orden4', ...
    'VariableNames', {'Frecuencia_kHz', 'Centrada_Orden2', 'Centrada_Orden4'});

disp(tabla_punto1);