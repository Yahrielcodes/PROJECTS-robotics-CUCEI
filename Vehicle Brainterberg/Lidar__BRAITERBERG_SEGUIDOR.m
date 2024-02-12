clear all
close all
clc

bot = TurtleBot3_WafflePI('http://192.168.50.100:11311');

S = 3000;
R = 0.195/2;
L = 0.381/2;
S = 60;
D = 0.08;
wr = 0.1*0;
wl = 0.1*0;
wo_l=0.8
wo_r=0.8
wi_r=0.12
wi_l=0.12
x_l =[]
y_l = []
tic;
while toc<=S
    [Angles,Ranges] = bot.Get_LaserScans()

    I = Ranges>=1.2;

    Ranges(I) = [];
    Angles(I) = []


    I_0_90 = Angles<=deg2rad(90) ;  %Guarda las posiciones de elementos que tengan 90 grados o menos
    I_270_360 = Angles>=deg2rad(270);%elementos que sean de 270 a 360


% 
%     %después de obtener la información en los sensores en los angulos
%     %que necesitamos procedemos a limitar su rango de alcance de 
%     %la siguiente manera 
%     I_0_90 =Ranges(I_0_90)<=0.70;%Guarda los elementos que sean menores a 0.50 mt
%     I_270_360 = Ranges(I_270_360)<=0.70;


    wr = wo_l + sum(Ranges(I_0_90))*wi_l
    wl = wo_r + sum(Ranges(I_270_360))*wi_r
     
     v = (R/2)*(wl+wr)
     w = (R*(wr-wl))/L
    bot.Set_Velocity(v,w);



     %Guarda rangos y angulos limitados para plotearlos
    [X_0_90,Y_0_90] = pol2cart(Angles(I_0_90),Ranges(I_0_90));% lado izquierdo
    [X_270_360,Y_270_360] = pol2cart(Angles(I_270_360),Ranges(I_270_360));%lado derecho

     Rangos_left = Ranges(I_0_90)<0.40
     Rangos_right = Ranges(I_270_360)<0.40
     
     if (any(Rangos_left))
          wr =0 
          wl =0
     end
     if (any(Rangos_right))
          wr =0 
          wl =0
     end
     v = (R/2)*(wl+wr)
     w = (R*(wr-wl))/L

    bot.Set_Velocity(v,w);
    cla
    hold on
    grid on

    scatter(X_270_360,Y_270_360,'red')
    scatter(X_0_90,Y_0_90,'blue')
    xlabel('x')
    ylabel('y')
    axis([-3 3 -3 3])
    drawnow
end
 bot.Set_Velocity(0,0);
bot.Stop_Connection()

