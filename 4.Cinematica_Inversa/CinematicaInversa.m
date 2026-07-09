clear;
clc;

%% Parámetros del robot
l1 = 15.554;
l2 = 16.190;
h1 = 12.57;
h2 = 0.87;
h3 = 0.41;
h4 = 5.40;
r1 = 1.054;

%% Posición deseada del efector final
Px = 14.6053;
Py = 25.5112;
Pz = 8.450;

%% Corrección por el desplazamiento de la base
Px1 = Px - r1;

%% Distancia al punto
b = sqrt(Px1^2 + Py^2);

%% Cálculo de theta2
cos_theta2 = (b^2 - l1^2 - l2^2)/(2*l1*l2);

% Evita errores numéricos
cos_theta2 = max(-1,min(1,cos_theta2));

sin_theta2 = sqrt(1-cos_theta2^2);      % Codo arriba
% sin_theta2 = -sqrt(1-cos_theta2^2);   % Codo abajo

theta2 = atan2(sin_theta2,cos_theta2);

%% Cálculo de theta1
alpha = atan2(Py,Px1);
phi = atan2(l2*sin_theta2,l1+l2*cos_theta2);

theta1 = alpha - phi;

%% Cálculo de la prismática
d3 = h1 + h2 + h3 - h4 - Pz;

%% Resultados
fprintf('Theta1 = %.4f grados\n',rad2deg(theta1));
fprintf('Theta2 = %.4f grados\n',rad2deg(theta2));
fprintf('d3 = %.4f cm\n',d3);