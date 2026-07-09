%Transformaciones (MTH)
clear;
clc;
%syms h1 h2 h3 h4 theta1 theta2 l1 l2 r1 d
theta1 = deg2rad(90);         % Angulo 1
theta2 = deg2rad(90);         % Angulo 2

r1= 1.054;                    % Desplazamiento de 0->1 en X
h1 = 12.57;                   % Desplazamiento de 0->1 en Z
h2 = 0.87;                    % Desplazamiento de 1->2 en Z

l1 = 15.554;                  % Medida Eslabon 1
l2 = 16.190;                  % Medida Eslabon 2

h3 = 0.41;                    % Desplazamiento de 2->3 en Z
h4 = 5.40;                    % Desplazamiento de 3->4 en Z

d = 0;                         % Desplazamiento de la prismatica
 

T01 = [1 0 0 r1;
       0 1 0 0;
       0 0 1 h1;
       0 0 0 1];

T12 = [cos(theta1) -sin(theta1) 0 l1*cos(theta1);
       sin(theta1) cos(theta1)  0 l1*sin(theta1);
       0           0            1 h2;
       0           0            0 1];
   
T23 = [cos(theta2) -sin(theta2) 0 l2*cos(theta2);
       sin(theta2) cos(theta2)  0 l2*sin(theta2);
       0           0            1 h3;
       0           0            0 1];
   
T34 = [1 0 0 0;
       0 1 0 0;
       0 0 1 -h4-d;
       0 0 0 1];

%T04 = simplify(T01*T12*T23*T34)
T01 = T01
T02 = T01*T12
T03 = T01*T12*T23
T04 = T01*T12*T23*T34 

% r = T04(1:3,1:3)
% m = rad2deg(tr2rpy(r,'zyx'))