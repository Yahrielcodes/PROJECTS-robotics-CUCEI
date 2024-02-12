
L1 = Revolute('a',0.0,'alpha',pi/2,'d',0.1283+0.115,'offset',0);
L2 = Revolute('a',0.280,'alpha',pi,'d',0.030,'offset',pi/2);
L3 = Revolute('a',0.0,'alpha',pi/2,'d',0.020,'offset',pi/2);
L4 = Revolute('a',0.0,'alpha',pi/2,'d',0.140+0.105,'offset',pi/2);
L5 = Revolute('a',0.0,'alpha',pi/2,'d',0.0285+0.0285,'offset',pi);
L6 = Revolute('a',0.0,'alpha',0,'d',0.105+0.130,'offset',pi/2);
bot = SerialLink([L1,L2,L3,L4,L5,L6], 'name', 'Kinova');

[isOk,baseFb, actuatorFb, interconnectFb] = gen3Kinova.SendRefreshFeedback();

q_kinova = actuatorFb.position(1:6);
q = deg2rad(wrapTo180(q_kinova));

bot.plot(q);
T06 = bot.fkine(q);

T06.t'
baseFb.tool_pose(1:3)

