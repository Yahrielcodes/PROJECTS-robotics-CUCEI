close all
clear all
clc

%%
Simulink.importExternalCTypes(which('kortex_wrapper_data.h'));
gen3Kinova = kortex();
gen3Kinova.ip_address = '192.168.2.10';
gen3Kinova.user = 'admin';
gen3Kinova.password = 'admin';
gen3Kinova.nbrJointActuators = 6;

% Verificar la conexión
isOk = gen3Kinova.CreateRobotApisWrapper();
if isOk
   disp('You are connected to the robot!'); 
else
   error('Failed to establish a valid connection!'); 
end

% Obtener sensores
[isOk,baseFb, actuatorFb, interconnectFb] = gen3Kinova.SendRefreshFeedback();
if isOk
    disp('Base feedback');
    disp(baseFb);
    disp('Actuator feedback');
    disp(actuatorFb);
    disp('Gripper feedback');
    disp(interconnectFb);
else
    error('Failed to acquire sensor data.'); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%definir articulaciones 
L1 = Revolute('a',0,'alpha',pi/2,'d',0.1283+0.115,'offset',0);
L2 = Revolute('a',0.280,'alpha',pi,'d',0.030,'offset',pi/2);
L3 = Revolute('a',0,'alpha',pi/2,'d',0.020,'offset',pi/2);
L4 = Revolute('a',0,'alpha',pi/2,'d',0.140+0.105,'offset',pi/2);
L5 = Revolute('a',0,'alpha',pi/2,'d',0.0285+0.0285,'offset',pi);
L6 = Revolute('a',0,'alpha',0,'d',0.105+ 0.130,'offset',pi/2);

bot = SerialLink([L1 L2 L3 L4 L5 L6],'name','Kinova');
estado = 0;
n = 1
while n<=4
%GENERACIÓN DE Q


%%
[isOk,baseFb, actuatorFb, interconnectFb] = gen3Kinova.SendRefreshFeedback();
if estado==0
% q_kinova = actuatorFb.position(1:6) + [-40 0 0 0 0 0];

%q_kinova = [50  336.0900   75.3360  359.8593  299.9946   49.9999]
q_kinova = [0 345 75 0 300 0]
end
%exportaciones y conversiones 
if estado == 1
    td = [0.043 0.425 0.1]';
    q_exportada = Algoritmo_control(bot,td)
    q_rad = q_exportada'
    q_kinova = rad2deg(q_rad)
    q_kinova = wrapTo360(q_kinova)

end
if estado == 2
    td = [0.043 0.425 0.03]';
    q_exportada = Algoritmo_control(bot,td)
    q_rad = q_exportada'
    q_kinova = rad2deg(q_rad)
    q_kinova = wrapTo360(q_kinova)
end

%% Mandar q
jointCmd = [q_kinova 0];
constraintType = int32(0);
speed = 0;
duration = 0;

isOk = gen3Kinova.SendJointAngles(jointCmd, constraintType, speed, duration);
if isOk
    disp('Command sent to the robot. Wait for the robot to stop moving.');
else
    disp('Command error.');
end
if estado == 0
    pause(5)
    AbrirGripper(gen3Kinova)
    pause(1)
    estado = estado + 1
n = n+1 
continue
end
if estado == 2
    pause(1)
    CerrarGripper(gen3Kinova)
    pause(2)
    estado = 0
    n = n+1 
    continue
end


estado = estado + 1
n = n+1 
pause(5)
end %endwhile
return
%%
% Control de gripper 
% Cerrar gripper


%%
% Abrir gripper


% Desconectar
isOk = gen3Kinova.DestroyRobotApisWrapper();


function q = Algoritmo_control(bot,td)
    
    q = [0 345 75 0 300 0]';
    q = deg2rad(q)
    
    Rd = rotx(270)*roty(0)*rotz(90);%!!!!!!!!!!
    
    Td = [[Rd td]; 0 0 0 1];
    
    K = diag([1 1 1 2 2 2]);
    
    S = 15;
    t = 0.05;
    N = S/t
    
    %algoritmo de control
    for i=1:N
        T = bot.fkine(q);
        ti = T.t;
        Ri = T.R;
    
        v = td-ti;
        w = 0.5*(cross(Ri(:,1),Rd(:,1))+cross(Ri(:,2),Rd(:,2))+cross(Ri(:,3),Rd(:,3)));
    
        e = [v; w];
    
        J = bot.jacob0(q);
    
        qp = pinv(J)*K*e;
    
        q = q + qp*t; 
    end
    q_exportada = q;
end 
function CerrarGripper(gen3Kinova)
    toolCommand = int32(3);    % position mode
    toolDuration = 0;
    toolCmd = 0.68;             % 0=abierto  1=cerrado
    isOk = gen3Kinova.SendToolCommand(toolCommand, toolDuration, toolCmd);
    if isOk
        disp('Command sent to the gripper. Wait for the gripper to stop moving.')
    else
        error('Command Error.');
    end
end
function AbrirGripper(gen3Kinova)
toolCommand = int32(3);    % position mode
    toolDuration = 0;
    toolCmd = 0;
    isOk = gen3Kinova.SendToolCommand(toolCommand, toolDuration, toolCmd);
    if isOk
        disp('Command sent to the gripper. Wait for the gripper to stop moving.')
    else
        error('Command Error.');
    end
end