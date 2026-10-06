%% Reproduce con Control System Toolbox los lazos cerrados de los modelos .slx
% y genera las figuras usadas en los README de esta carpeta.
% Los parametros de los controladores son los guardados en los bloques PID de:
%   ComparacionMetodos.slx, Asignacion_Polos/AsignacionPolos.slx y Metodo_Rele/MetodoRele.slx
% Salida: PNG en images/ de cada subcarpeta.
clear; clc; close all
base = fileparts(mfilename('fullpath'));
dirComp  = fullfile(base, 'images');
dirPolos = fullfile(base, 'Asignacion_Polos', 'images');
dirRele  = fullfile(base, 'Metodo_Rele', 'images');
for d = {dirComp, dirPolos, dirRele}, if ~exist(d{1},'dir'), mkdir(d{1}); end, end
set(0,'DefaultFigureVisible','off');

%% Planta: motor DC + reductor 275.69:1 (theta salida / V)  -- linealizacion del modelo Simscape
s = tf('s');
G = 33792/(s^3 + 2500*s^2 + 55822*s);
N = 100;                                   % filtro derivativo de los bloques PID de Simulink
mk = @(Kp,Ki,Kd) pid(Kp,Ki,Kd,1/N);

%% Controladores (Kp, Ki, Kd de los bloques PID de los .slx)
C.Leonard        = mk(26.1447, 46.1855, 0.4974);   % Leonard (1994)
C.CluettWang     = mk(9.5711, 15.6962, 0.0564);    % Cluett y Wang (1997), TCL = 6 tm
C.AstromHagglund = mk(15.8988, 42.8309, 0.3689);   % Astrom y Hagglund (2006)
C.Polos          = mk(12.11, 2.4, 0.147);          % Asignacion de polos (ComparacionMetodos.slx)
C.PolosPID       = mk(12.1164, 2.7060, 0.1479);    % Asignacion de polos PID (valores del calculo analitico)
C.PolosPI        = mk(10.0368, 2.2107, 0);         % Asignacion de polos PI (valores del calculo analitico)
C.Rele           = pid(10.817);                    % Z-N (P) con epsilon = 1
metodos = {'Leonard','CluettWang','AstromHagglund','Polos','Rele'};
leyenda = {'Referencia','Leonard (1994)','Cluett y Wang (T_{CL}=6\tau_m)', ...
           'Åström y Hägglund (2006)','Asignación de polos','Método del relé (\epsilon=1), P'};

%% Referencia: escalera de 10 saltos acumulados (ComparacionMetodos.slx)
tk = [1 4 15 26 38 48 58 68 78 88];
dr = [0.0017453 0.0174533 0.0872665 0.1745329 0.3490659 0.5235988 0.7853982 1.0471976 1.5707963 2.268928];
Tend = 98;
t = (0:0.001:Tend)';
r = zeros(size(t));
for k = 1:numel(tk), r = r + dr(k)*(t>=tk(k)); end
Y = zeros(numel(t), numel(metodos));
for i = 1:numel(metodos)
    Y(:,i) = lsim(feedback(C.(metodos{i})*G, 1), r, t);
end
col = lines(5);

%% Figura: escalera completa
f = figure('Position',[100 100 1100 520]);
plot(t, r, 'k--', 'LineWidth', 1.2); hold on
for i = 1:5, plot(t, Y(:,i), 'Color', col(i,:), 'LineWidth', 1.1); end
grid on; xlabel('Tiempo [s]'); ylabel('\theta [rad]'); xlim([0 100])
title('Respuesta a la referencia escalonada (10 saltos acumulados)')
legend(leyenda, 'Location', 'northwest')
exportgraphics(f, fullfile(dirComp,'comparacion_escalera.png'), 'Resolution', 150);

%% Figura: zoom al salto 5 (+20 grados en t = 38 s)
idx = t >= 37 & t < 44;
f = figure('Position',[100 100 900 480]);
plot(t(idx), r(idx), 'k--', 'LineWidth', 1.2); hold on
for i = 1:5, plot(t(idx), Y(idx,i), 'Color', col(i,:), 'LineWidth', 1.4); end
grid on; xlabel('Tiempo [s]'); ylabel('\theta [rad]')
title('Zoom al salto 5 (+20^\circ en t = 38 s)')
legend(leyenda, 'Location', 'southeast')
exportgraphics(f, fullfile(dirComp,'comparacion_zoom_salto5.png'), 'Resolution', 150);

%% Figura: asignacion de polos, escalon unitario (PID y PI)
t2 = (0:0.0005:30)';
Tpid = feedback(C.PolosPID*G, 1);  Tpi = feedback(C.PolosPI*G, 1);
ypid = step(Tpid, t2);             ypi  = step(Tpi, t2);
f = figure('Position',[100 100 1000 620]);
subplot(2,2,1); plot(t2, ypid, 'LineWidth',1.4); yline(1,'k:'); grid on; xlim([0 30])
title('PID (\zeta=0.96, t_s=0.33 s) - 0 a 30 s'); ylabel('\theta/\theta_{ref}')
subplot(2,2,2); plot(t2, ypi, 'LineWidth',1.4,'Color',col(2,:)); yline(1,'k:'); grid on; xlim([0 30])
title('PI (\zeta=0.97, t_s=0.36 s) - 0 a 30 s')
subplot(2,2,3); plot(t2, ypid, 'LineWidth',1.4); yline(1,'k:'); xline(0.33,'r--','t_s diseño'); grid on; xlim([0 1.5])
title('PID - zoom 0 a 1.5 s'); xlabel('Tiempo [s]'); ylabel('\theta/\theta_{ref}')
subplot(2,2,4); plot(t2, ypi, 'LineWidth',1.4,'Color',col(2,:)); yline(1,'k:'); xline(0.36,'r--','t_s diseño'); grid on; xlim([0 1.5])
title('PI - zoom 0 a 1.5 s'); xlabel('Tiempo [s]')
exportgraphics(f, fullfile(dirPolos,'polos_escalon_unitario.png'), 'Resolution', 150);
for c = {{'PID',Tpid,ypid},{'PI',Tpi,ypi}}
    y = c{1}{3};  tc = find(y >= 0.98, 1);
    fprintf('%s: sobrepico %.2f %%, llega al 98 %% en %.3f s, polos: %s\n', c{1}{1}, (max(y)-1)*100, t2(tc), mat2str(round(pole(c{1}{2}),3),5));
end

%% Relé con histéresis: ciclo límite (d = 5 V) y comparación con los datos medidos en el Excel
[num, den] = tfdata(G, 'v');  [Ag,Bg,Cg] = tf2ss(num, den);
d = 5;  dt = 1e-4;  tmax = 30;
epsXl = [0.1 0.2 0.3 0.5 0.7 1];
PuXl  = [0.2962 0.4396 0.5766 0.8401 1.0988 1.5066];
AuXl  = [0.2759 0.4829 0.6844 1.0839 1.4820 2.0848];
mostrar = [0.1 0.5 1];
f = figure('Position',[100 100 1000 700]);
fprintf('Rele (d=5): periodo Pu y amplitud Au simulados vs Excel\n');
for kk = 1:6
    e = epsXl(kk);  x = zeros(3,1);  u = d;
    n = round(tmax/dt);  Tv = (1:n)'*dt;  Yy = zeros(n,1);  Uu = zeros(n,1);
    for j = 1:n
        yv = Cg*x;  err = -yv;
        if u > 0 && err < -e, u = -d; elseif u < 0 && err > e, u = d; end
        k1 = Ag*x + Bg*u;  k2 = Ag*(x+dt/2*k1) + Bg*u;  k3 = Ag*(x+dt/2*k2) + Bg*u;  k4 = Ag*(x+dt*k3) + Bg*u;
        x = x + dt/6*(k1 + 2*k2 + 2*k3 + k4);
        Yy(j) = yv;  Uu(j) = u;
    end
    ss = Tv > 0.6*tmax;
    ups = find(diff(Uu(ss)) > 0) + 1;  tss = Tv(ss);
    Pu = mean(diff(tss(ups)));  Au = max(Yy(ss)) - min(Yy(ss));
    fprintf('  eps=%.1f  Pu=%.4f (Excel %.4f)   Au=%.4f (Excel %.4f)\n', e, Pu, PuXl(kk), Au, AuXl(kk));
    p = find(abs(mostrar-e) < 1e-9);
    if ~isempty(p)
        subplot(3,1,p)
        win = Tv > tmax-4*Pu & Tv <= tmax;
        yyaxis left;  plot(Tv(win), Yy(win), 'LineWidth',1.2); ylabel('y(t) [rad]')
        yyaxis right; plot(Tv(win), Uu(win), 'LineWidth',1.0); ylabel('u(t) [V]'); ylim([-7 7])
        xlim([Tv(find(win,1)) tmax]); grid on
        title(sprintf('\\epsilon = %.1f   (P_u = %.3f s, A_u = %.3f)', e, Pu, Au))
        if p == 3, xlabel('Tiempo [s]'); end
    end
end
exportgraphics(f, fullfile(dirRele,'rele_ciclo_limite.png'), 'Resolution', 150);

%% K_u y P_u en funcion de epsilon (datos del Excel)
Ku = 4*d./(pi*sqrt((AuXl/2).^2 - epsXl.^2));
f = figure('Position',[100 100 900 380]);
subplot(1,2,1); plot(epsXl, Ku, 'o-', 'LineWidth',1.4); grid on; xlabel('\epsilon'); ylabel('K_u'); title('Ganancia última K_u')
subplot(1,2,2); plot(epsXl, PuXl, 's-', 'LineWidth',1.4, 'Color', col(2,:)); grid on; xlabel('\epsilon'); ylabel('P_u [s]'); title('Periodo último P_u')
exportgraphics(f, fullfile(dirRele,'rele_Ku_Pu_vs_eps.png'), 'Resolution', 150);
disp('Figuras generadas.')
