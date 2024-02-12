clear all
close all
%clc
format long
ng=1;
kg=3.71;
jm=3.9*10^(-7);
rm=6.35*10^(-3);
nm=1;
kt=0.00767;
Rm=2.6;
km=0.00767;
M_p=0.127;
I_p=(1/12)*M_p*0.3365^2;
l_p=0.1778;   %todas las variables del pendulo largo
b_eq=5.4;
b_p=0.0024;
g=9.81;
M_c=0.57;   %aun falta por aclarar


b1=ng*kg^2*jm/rm^2;
b2=ng*nm*kg*kt/(Rm*rm);
b3=(ng*nm*kg^2*km*kt)/(Rm*rm^2);


a1=(M_c+M_p+b1)*(M_p*l_p^2+I_p)-M_p^2*l_p^2;
a2=(M_p*l_p*b_p)/(a1);
a3=(M_p^2*l_p^2*g)/(a1);
a4=((M_p*l_p^2+I_p)*b2)/(a1);
a5=((M_p*l_p^2+I_p)*(b3+b_eq))/(a1);
a6=(M_c+M_p+b1)*b_p/(a1);
a7=(M_c+M_p+b1)*M_p*g*l_p/(a1);
a8=(M_p*l_p)*b2/(a1);
a9=(M_p*l_p)*(b3+b_eq)/(a1);





A=[0,0,1,0;0,0,0,1;0,a3,-a5,-a2;0,a7,-a9,-a6];
%Sigue representado en termino de F_c y no de V_m

B=[0;0;a4;a8];

C=eye(4,4);
D=[0;0;0;0];


estabilidad=eig(A);  %para revisar la estabilidad es necesario conocer los eigenvalores de la matriz A los cuales serian
                    % igual a los polos de nuesta funcion de transferencia



% para saber si el sistema es controlable

Co=ctrb(A,B);
controlable=rank(Co);



%observabilidad
Ob=obsv(A,C);
observabilidad=rank(Ob);


%se buscan los valores k




Q=[2,0,0,0;                            %0.9
    0,10,0,0;
    0,0,0,0;                           % 0.2
    0,0,0,0]
R=[0.005]


[K,S,CLP]=lqr(A,B,Q,R);
K











