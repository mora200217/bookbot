%% main doc for tests 
addpath("utilities/")
addpath("dijkstra/")
clear; clc; close all; 
load("occupancy_map_bib.mat"); 

R = 0.1016; % [m]
L = 0.62; % [m]

traj = planner(map, G, waypoints, 13, 21); 
out = sim("traj_follower.slx")

% Extracción de datos 
simtraj = out.path.Data; 
simvel = out.vel.Data; 

hold on; 
%show(map)
plot(simtraj(:, 1),simtraj(:, 2), "LineWidth",1, "LineStyle","--"); 
plot(traj(2:end, 1), traj(2:end, 2), "LineWidth",1, "LineStyle","-"); 
legend("grafo", "simulada", "planeada"); 
hold off; 
title("trayectoria")
xlabel("x [m]")
ylabel("y [m]")


%% Velocidades angulares 
t = out.tout; 

v = simvel(:, 1); 
w = simvel(:, 2); 

wr = ((2*v + w*L)/(2*R)); 
wl = ((2*v - w*L)/(2*R)); 

figure; 
plot(t, wr, t, wl); 
title("Velocidades angulares")
grid on; 
xlabel("time [s]"); 
ylabel("\omega [rad/s]"); 
legend("\omega_l", "\omega_r")

%% Aceleraciones y torques 










