clear all
close all
clc
%PROYECTO ALDANA IP02 
ng=1  %Planetari gear box efficency (MODIFICADO POR NOSOTROS )0.8
kg=3.71 %Planetari gear box ratio
jm=3.9e-007 %Rotor moment of Inertia 
rmp=6.35e-003    %Motor pinion radius 
nm=1 %Motor effiency (MODIFICADO POR NOSOTROS ) %0.9
kt=0.00767  %Motor torque constant 
Rm=2.6 %Motor  Armature Resistance 
km=0.00767 %back electromotive-force constant 
M=0.57; %CAR MASS
M_recommendend = 0.94 %CARMASS WITH WEIGHT 
B_eq=5.4; %EQUIVALENT BISCUS FRICCTION 

a = rmp*ng*kg*nm*kt
b = Rm*M*rmp^2+Rm*ng*kg^2*jm
c = ng*kg^2*nm*kt*km+B_eq*Rm*rmp^2

integrator = tf([0 1],[1 0]) %representacion de integrador en codigo 
num_p=[a];
den_p=[b,c];
g = tf(num_p,den_p) %planta 
k = 2.42931e+3;
 %compensador de adelanto 
nc = [6.2783 80];
dc = [1 502.2629];
gc =tf(nc,dc);
k_c= 1;
g_feeded = feedback(g*integrator*k,1);  %retroalimentacion solo k e intg
figure(1)
bode(g_feeded) %bode retrilimentado 
bode(g*integrator )
%k=3561
wd = 80
w = 0.131
K_necesari = (sqrt((b*wd^2)^2+(c*wd)^2))/(sqrt((b*w^2)^2+(c*w)^2))
figure(2) 
margin(g*integrator*K_necesari) 
k = K_necesari


% figure(3)
% margin(g*integrator*gc*k*5.14454016)

finally =feedback( (g*integrator*gc*k*k_c),1)
figure(4)
bode(finally)
figure(5)
G_all=(g*integrator*gc*k*k_c)
margin(G_all)

%step(finally)
%  figure(6)
%  bode(gc)


%--------------------------------------------



% gf_cerrado = feedback(g,1)
% figure(1)
% bode(g_complete)
% %step(gf_cerrado)
% %figure(2)
% %[Gm,Pm,Wcg,Wcp] = margin(g_K)
% 
%  
% [Gm_k,Pm_k,Wcg_k,Wcp_k] = margin(gf)
% figure(2)
% bode(gf_cerrado)
% title("lazo cerrado")
% figure(3)
% step(gf_cerrado)
% % g_cerrado=feedback(g,1)
% % 
% 


% 
% 
