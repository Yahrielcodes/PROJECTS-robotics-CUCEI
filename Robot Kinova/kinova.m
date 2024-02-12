%Uribe Rosas Jose Yahriel
%217035347
%kinova

%Crear matrices 
clc
clear all 
%definir articulaciones 
L1 = Revolute('a',0,'alpha',pi/2,'d',0.1283+0.115,'offset',0);
L2 = Revolute('a',0.280,'alpha',pi,'d',0.030,'offset',pi/2);
L3 = Revolute('a',0,'alpha',pi/2,'d',0.020,'offset',pi/2);
L4 = Revolute('a',0,'alpha',pi/2,'d',0.140+0.105,'offset',pi/2);
L5 = Revolute('a',0,'alpha',pi/2,'d',0.0285+0.0285,'offset',pi);
L6 = Revolute('a',0,'alpha',0,'d',0.105+ 0.130,'offset',pi/2);

bot = SerialLink([L1 L2 L3 L4 L5 L6],'name','Kinova');

% cinematica directa 

%
S = 15;
t = 0.05;
N = S/t;

td = [0.043 0.425 0.1]';


%singularidades a evitar
%q2 = 0 and q5 = 0  
%q2 = 0 and q3 = 0
%q3 = 0 and q4 = π / 2
%q4 = π / 2 and q5 = 0

      %q1  %q2  %q3 %q4 %q5 %q6
% q = [0 pi/2 pi/2 pi/4 pi/2 0]';
q = [0 345 75 0 300 0]';
q = deg2rad(q)

% el order de las multiplicaciones define el order de las rotacione

%!!!!!!!!PRESTA ATENCION AQUÍ A LA HORA DE AGARRAR EL CUBO

Rd = rotx(270)*roty(0)*rotz(90);%!!!!!!!!!!

Td = [[Rd td]; 0 0 0 1];

% cuando resolvemos ik solo para td, K(3x3), para Td, K(6x6).
K = diag([1 1 1 2 2 2]);

                   %------pregunta 1 ¿por que se llenan de%ceros?--------
t_plot = zeros(3,N);
td_plot = zeros(3,N);

q_plot = zeros(6,N);
qp_plot = zeros(6,N);
manipulabilidad = []

%algoritmo de control
for i=1:N
     %--elegir de izquierda a derecha que determina eso?
    T = bot.fkine(q);
    ti = T.t;
    Ri = T.R;

    v = td-ti;
    w = 0.5*(cross(Ri(:,1),Rd(:,1))+cross(Ri(:,2),Rd(:,2))+cross(Ri(:,3),Rd(:,3)));

    e = [v; w];

    J = bot.jacob0(q);

    qp = pinv(J)*K*e;

    q = q + qp*t;

    q_plot(:,i) = q;
    qp_plot(:,i) = qp;

    t_plot(:,i) = ti;
    td_plot(:,i) = td;
     manip = abs(det(J));
    manipulabilidad_plot(i) = manip;
    
end
q_exportada = q;


% figure
% bot.plot(q')
% 
% figure
% bot.plot(q_plot')
% 
% 
% bot.fkine(q)

% return
time = t:t:S;
figure
plot(time,q_plot')
title('posicion')

figure
plot(time,qp_plot')
title('velocidad')

figure
hold on
grid on
plot(time,td_plot(1,:))
plot(time,t_plot(1,:))
title('x')

figure
hold on
grid on
plot(time,td_plot(2,:))
plot(time,t_plot(2,:))
title('y')

figure
hold on
grid on
plot(time,td_plot(3,:))
plot(time,t_plot(3,:))
title('z')

figure 
hold on
grid on
title("manipulabilidad")
plot(time,manipulabilidad_plot)










tdfinal = Td(1:3,4)

prueba = td - tdfinal





















