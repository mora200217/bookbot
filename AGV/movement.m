%% movement.m 
% Planeacion de movimiento y validacion de perfiles 
% cinematicos.

% Parámetros 
R = 0.1016; % m -> 4" de radio 
L = 0.5; % m separación entre llantas 

%% Modelo de robot diferencial 
bookbot = differentialDriveKinematics("TrackWidth",L, "WheelRadius",R);
initialState = [0, 0, 0]; 

tspan = 0:0.05:1;
inputs = [50 50]; %Left wheel is spinning faster
[t,y] = ode45(@(t,y)derivative(bookbot,y,inputs),tspan,initialState);

plot(t, y)

%% Planeador 
q0 = [6, 0.5]; 
qf = [2, 6]; 
planner = mobileRobotPRM(map, 20); 
planner.update()
planner.findpath(q0, qf)
planner.show()




