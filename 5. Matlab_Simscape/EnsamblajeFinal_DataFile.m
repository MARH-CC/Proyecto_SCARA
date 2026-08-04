% Simscape(TM) Multibody(TM) version: 25.2

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(7).translation = [0.0 0.0 0.0];
smiData.RigidTransform(7).angle = 0.0;
smiData.RigidTransform(7).axis = [0.0 0.0 0.0];
smiData.RigidTransform(7).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [1.0539999999999998 0 12.57];  % cm
smiData.RigidTransform(1).angle = 1.0614028251439894e-16;  % rad
smiData.RigidTransform(1).axis = [-1 0 -0];
smiData.RigidTransform(1).ID = "B[Parte1-1:-:Parte2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [2.2204460492503131e-16 0 1.7763568394002505e-15];  % cm
smiData.RigidTransform(2).angle = 1.0614028251439894e-16;  % rad
smiData.RigidTransform(2).axis = [-1 0 -0];
smiData.RigidTransform(2).ID = "F[Parte1-1:-:Parte2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [15.553779520868675 -0.0015200587151021296 0.87000000000004574];  % cm
smiData.RigidTransform(3).angle = 5.663496672084438e-16;  % rad
smiData.RigidTransform(3).axis = [-0.19831921570794528 -0.98013748458110983 5.5043551688535159e-17];
smiData.RigidTransform(3).ID = "B[Parte2-1:-:Parte3-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [0 -1.5343247505850144e-12 8.8817841970012523e-15];  % cm
smiData.RigidTransform(4).angle = 5.663496672084438e-16;  % rad
smiData.RigidTransform(4).axis = [-0.19831921570794528 -0.98013748458110983 5.5043551688535159e-17];
smiData.RigidTransform(4).ID = "F[Parte2-1:-:Parte3-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [16.190000000000012 0 0.40999999999999925];  % cm
smiData.RigidTransform(5).angle = 0;  % rad
smiData.RigidTransform(5).axis = [0 0 0];
smiData.RigidTransform(5).ID = "B[Parte3-1:-:CremalleraDesde0-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [7.1054273576010019e-15 -4.4768600718919638e-12 -8.1712414612378604e-14];  % cm
smiData.RigidTransform(6).angle = 3.141592653589786;  % rad
smiData.RigidTransform(6).axis = [1 0 0];
smiData.RigidTransform(6).ID = "F[Parte3-1:-:CremalleraDesde0-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 0 0];  % cm
smiData.RigidTransform(7).angle = 0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = "RootGround[Parte1-1]";


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(4).mass = 0.0;
smiData.Solid(4).CoM = [0.0 0.0 0.0];
smiData.Solid(4).MoI = [0.0 0.0 0.0];
smiData.Solid(4).PoI = [0.0 0.0 0.0];
smiData.Solid(4).color = [0.0 0.0 0.0];
smiData.Solid(4).opacity = 0.0;
smiData.Solid(4).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 1.5816756007778852;  % kg
smiData.Solid(1).CoM = [0.009230805047193388 1.0434490342751922e-07 3.7490317180818606];  % cm
smiData.Solid(1).MoI = [31.16002843913579 31.30157580369146 40.020585337105786];  % kg*cm^2
smiData.Solid(1).PoI = [-1.6066554601350753e-06 -0.1117922884470695 -0.00074412577953519453];  % kg*cm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "Parte1*:*Predeterminado";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.34054381760822522;  % kg
smiData.Solid(2).CoM = [8.3113449367787489 -0.00080940976844394343 -0.25668801571379263];  % cm
smiData.Solid(2).MoI = [2.1037299074435878 14.89144575278725 15.660776910248615];  % kg*cm^2
smiData.Solid(2).PoI = [-0.00015815823056392072 1.6137575627492871 0.00051128388030807651];  % kg*cm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "Parte2*:*Predeterminado";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.059830751926282927;  % kg
smiData.Solid(3).CoM = [-0.10073132914310504 -1.8435531551014506e-08 -0.032759739917892626];  % cm
smiData.Solid(3).MoI = [0.63112031331643359 0.62704405175175959 0.081589932200798951];  % kg*cm^2
smiData.Solid(3).PoI = [4.5947624604686631e-10 0.0014852892644228325 9.29718147685809e-10];  % kg*cm^2
smiData.Solid(3).color = [0.69411764705882351 0.098039215686274508 0.098039215686274508];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "CremalleraDesde0*:*Predeterminado";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.32324660921199505;  % kg
smiData.Solid(4).CoM = [7.65582378730796 0.51898258381127882 0.70439649984792874];  % cm
smiData.Solid(4).MoI = [2.0444221519292465 12.433807043268137 14.04019209090294];  % kg*cm^2
smiData.Solid(4).PoI = [-0.1319677900450397 -0.29411585135717944 -1.0203574676965668];  % kg*cm^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "Parte3*:*Predeterminado";


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the PrismaticJoint structure array by filling in null values.
smiData.PrismaticJoint(1).Pz.Pos = 0.0;
smiData.PrismaticJoint(1).ID = "";

smiData.PrismaticJoint(1).Pz.Pos = 0;  % m
smiData.PrismaticJoint(1).ID = "[Parte3-1:-:CremalleraDesde0-1]";


%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(2).Rz.Pos = 0.0;
smiData.RevoluteJoint(2).ID = "";

smiData.RevoluteJoint(1).Rz.Pos = 0;  % deg
smiData.RevoluteJoint(1).ID = "[Parte1-1:-:Parte2-1]";

smiData.RevoluteJoint(2).Rz.Pos = 0;  % deg
smiData.RevoluteJoint(2).ID = "[Parte2-1:-:Parte3-1]";

