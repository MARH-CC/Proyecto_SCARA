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
dirLit   = fullfile(base, 'SintonizacionLiteratura', 'images');
for d = {dirComp, dirPolos, dirRele, dirLit}, if ~exist(d{1},'dir'), mkdir(d{1}); end, end
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
%% Caracterización: ensayos al escalón (1, 2.5 y 5 V) y construcción de K_m y tau_m
V  = [1 2.5 5];
T1 = 1;  T2 = 1.0464;  T3 = [1.5017 1.2378 1.2001];
O2 = [0.2766 0.2924 0.4711];
Km = O2 ./ (V .* (T3 - T2));                 % K_m = (O2-O1)/((I2-I1)(T3-T2)), con O1 = I1 = 0
f = figure('Position',[100 100 1250 400]);
for k = 1:3
    tt = (0.9:0.0005:T3(k)+0.15)';
    y  = lsim(G, V(k)*(tt >= T1), tt);
    subplot(1,3,k); hold on
    plot(tt, y, 'LineWidth', 1.8, 'Color', col(1,:))
    tr = [T2 T3(k)+0.15];
    plot(tr, Km(k)*V(k)*(tr-T2), 'k--', 'LineWidth', 1.1)
    yl = [0 1.25*O2(k)];
    for tm_ = [T1 T2 T3(k)], plot([tm_ tm_], yl, ':', 'Color', [0.4 0.4 0.4]); end
    plot(T3(k), O2(k), 'ro', 'MarkerFaceColor', 'r')
    text(T1, yl(2)*0.97, 'T_1', 'HorizontalAlignment','right', 'FontSize', 11)
    text(T2, yl(2)*0.97, ' T_2', 'HorizontalAlignment','left', 'FontSize', 11)
    text(T3(k), yl(2)*0.97, 'T_3 ', 'HorizontalAlignment','right', 'FontSize', 11)
    text(T3(k)+0.01, O2(k)*0.82, sprintf('O_2 = %.4f', O2(k)), 'Color', 'r', 'FontSize', 10)
    ylim(yl); xlim([0.9 T3(k)+0.15]); grid on
    xlabel('Tiempo [s]'); if k == 1, ylabel('\theta [rad]'); end
    title({sprintf('Escalón de %g V', V(k)), ['K_m = ' num2str(Km(k),'%.4f') ',  \tau_m = ' num2str(T2-T1,'%.4f') ' s']})
end
exportgraphics(f, fullfile(dirLit,'caracterizacion_ensayos.png'), 'Resolution', 150);
fprintf('Km (calculado con las lecturas): %s\n', mat2str(round(Km,4)));

%% Asignación de polos: diagrama del lazo y mapa de polos
f = figure('Position',[100 100 1100 280]); axes('Position',[0 0 1 1]); axis([0 14.2 0 4]); axis off; hold on
caja(2.6,1.2,4.0,1.6, '$C(s)=K_p+\frac{K_i}{s}+K_d\,s$');
caja(8.0,1.2,4.6,1.6, '$G(s)=\frac{33792}{s^3+2500\,s^2+55822\,s}$');
th_ = linspace(0,2*pi,60); plot(1.4+0.28*cos(th_), 2+0.28*sin(th_), 'k', 'LineWidth', 1.2)
text(1.4, 2, '$\Sigma$', 'Interpreter','latex', 'HorizontalAlignment','center', 'FontSize', 13)
text(1.05, 2.3, '$+$', 'Interpreter','latex', 'FontSize', 12); text(1.45, 1.55, '$-$', 'Interpreter','latex', 'FontSize', 12)
flecha(0.3,2,1.12,2);   text(0.3, 2.3, '$R(s)$', 'Interpreter','latex', 'FontSize', 13)
flecha(1.68,2,2.6,2);   text(2.0, 2.3, '$E(s)$', 'Interpreter','latex', 'FontSize', 12)
flecha(6.6,2,8.0,2);    text(7.05, 2.3, '$U(s)$', 'Interpreter','latex', 'FontSize', 12)
flecha(12.6,2,13.8,2);  text(13.2, 2.3, '$Y(s)$', 'Interpreter','latex', 'FontSize', 13)
plot([13.2 13.2 1.4 1.4], [2 0.6 0.6 1.72], 'k', 'LineWidth', 1.2); flecha(1.4,0.9,1.4,1.72)
plot(13.2, 2, 'k.', 'MarkerSize', 14)
exportgraphics(f, fullfile(dirPolos,'lazo_cerrado.png'), 'Resolution', 150);

zp = 0.96; wn = 4/(0.96*0.33);
Kpd = 409438/33792; Kid = 91442/33792; Kdd = 4998/33792;
pdes = roots(conv([1 24.271 159.77], conv([1 0.2312],[1 2475.5])));
f = figure('Position',[100 100 1250 470]); subplot(1,2,1); hold on
a = acos(zp);  rr = 30;
fill([0 -rr*cos(a) -rr*cos(a) 0], [0 rr*sin(a) -rr*sin(a) 0], [0.9 0.95 1], 'EdgeColor','none')
plot([0 -rr*cos(a)], [0 rr*sin(a)], '--', 'Color', [0.4 0.4 0.4]); plot([0 -rr*cos(a)], [0 -rr*sin(a)], '--', 'Color', [0.4 0.4 0.4])
th_ = linspace(pi/2, 3*pi/2, 200); plot(wn*cos(th_), wn*sin(th_), ':', 'Color', [0.4 0.4 0.4])
h1 = plot([0 -22.53], [0 0], 'kx', 'MarkerSize', 11, 'LineWidth', 2);
h2 = plot(real(pdes(abs(pdes)<100)), imag(pdes(abs(pdes)<100)), 'rx', 'MarkerSize', 11, 'LineWidth', 2);
zz = roots([Kdd Kpd Kid]);
h3 = plot(zz(abs(zz)<30), 0*zz(abs(zz)<30), 'bo', 'MarkerSize', 9, 'LineWidth', 1.5);
text(-12.14, 4.4, '$-12.14\pm3.54\,j$', 'Interpreter','latex', 'HorizontalAlignment','center', 'Color','r', 'FontSize', 12)
text(-0.231, -1.0, '$-0.231$', 'Interpreter','latex', 'HorizontalAlignment','right', 'Color','r', 'FontSize', 12)
text(-22.53, -1.0, '$-22.5$', 'Interpreter','latex', 'HorizontalAlignment','center', 'FontSize', 12)
text(-0.224, 1.0, '$-0.224$', 'Interpreter','latex', 'HorizontalAlignment','right', 'Color','b', 'FontSize', 12)
text(-19, 5.6, '$\zeta=0.96$', 'Interpreter','latex', 'FontSize', 12, 'Color',[0.3 0.3 0.3])
xlim([-28 3]); ylim([-8 8]); grid on; xlabel('Re'); ylabel('Im')
title('Plano s (zoom)')
legend([h1 h2 h3], {'Polos de la planta', 'Polos de lazo cerrado', 'Cero del PID'}, 'Location','southwest')
subplot(1,2,2); hold on
plot([-0.6 0.15], [0 0], 'k-', 'Color', [0.7 0.7 0.7])
plot(0, 0, 'kx', 'MarkerSize', 12, 'LineWidth', 2)
plot(-0.2312, 0, 'rx', 'MarkerSize', 12, 'LineWidth', 2)
plot(zz(abs(zz)<1), 0, 'bo', 'MarkerSize', 10, 'LineWidth', 1.5)
text(0, 0.045, '$0$', 'Interpreter','latex', 'HorizontalAlignment','center', 'FontSize', 12)
text(-0.2312, -0.045, '$-0.231$', 'Interpreter','latex', 'HorizontalAlignment','center', 'Color','r', 'FontSize', 12)
text(-0.2239, 0.045, '$-0.224$', 'Interpreter','latex', 'HorizontalAlignment','center', 'Color','b', 'FontSize', 12)
xlim([-0.6 0.15]); ylim([-0.15 0.15]); grid on; xlabel('Re'); ylabel('Im')
title('Cerca del origen: el cero casi cancela el polo lento')
sgtitle('Asignación de polos del PID: polos de la planta (0, -22.5 y -2477.5), polos deseados (-12.14 ± 3.54j, -0.231 y -2475.5) y ceros (-0.224 y -81.7)', 'FontSize', 10)
exportgraphics(f, fullfile(dirPolos,'mapa_polos.png'), 'Resolution', 150);

disp('Figuras generadas.')

function caja(x, y, w, h, tx)
    rectangle('Position',[x y w h], 'LineWidth', 1.3, 'FaceColor', [0.95 0.97 1])
    text(x+w/2, y+h/2, tx, 'Interpreter','latex', 'HorizontalAlignment','center', 'FontSize', 13)
end
function flecha(x1, y1, x2, y2)
    plot([x1 x2], [y1 y2], 'k', 'LineWidth', 1.2)
    d = [x2-x1 y2-y1]; d = d/norm(d); n = [-d(2) d(1)]; L = 0.17; W = 0.075;
    patch([x2, x2-L*d(1)+W*n(1), x2-L*d(1)-W*n(1)], [y2, y2-L*d(2)+W*n(2), y2-L*d(2)-W*n(2)], 'k')
end

