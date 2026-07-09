close all; clear all; clc

%% Parámetros
l1 = 15.554;
l2 = 16.190;
h1 = 12.57;
h2 = 0.87;
h3 = 0.41;
h4 = 5.40;
r1 = 1.054;
d3 = 0;

%% Cinemática Inversa
Pxd = 14.6053;
Py = 25.5112;
Pz =   8.450;

Px = Pxd - r1;

b = sqrt(Px^2 + Py^2);

%% theta2
cos_theta2 = (b^2 - l1^2 - l2^2) / (2*l1*l2);
cos_theta2  = max(-1, min(1, cos_theta2));
sen_theta2  = sqrt(1 - cos_theta2^2);
theta2 = atan2(sen_theta2, cos_theta2);
fprintf('theta2: %.4f deg\n', rad2deg(theta2))

%% theta1
alpha  = atan2(Py, Px);
phi    = atan2(l2*sen_theta2, l1 + l2*cos_theta2);
theta1 = alpha - phi;
fprintf('theta1: %.4f deg\n', rad2deg(theta1))

%% d3
d3 = h1 + h2 + h3 - h4 - Pz;
fprintf('d3: %.4f cm\n', d3)

%% Joints
q1 = theta1;
q2 = theta2;
q3 = d3;

%% Modelo DH (3 joints, T01 absorbido en base)
R(1) = Link('revolute',  'd', h2, 'alpha',  0,  'a', l1, 'offset', 0);
R(2) = Link('revolute',  'd', h3, 'alpha', -pi, 'a', l2, 'offset', 0);
R(3) = Link('prismatic', 'theta', 0, 'alpha', 0, 'a', 0, 'offset', h4);
R(3).qlim = [0, 10];

Robot = SerialLink(R, 'name', 'SCARA');
Robot.base = transl(r1, 0, h1);  % absorbe T01: traslada r1 en X y h1 en Z

Robot.plot([q1,q2,q3], 'scale', 1.2, 'workspace', [-40 40 -40 40 -25 25]);
Robot.teach([q1,q2,q3])
Robot.fkine([q1,q2,q3])