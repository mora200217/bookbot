% Creacion de mapa de ocupacion binario 
clear; clc; close all; 

% Parametros de diseño 
ancho_estante = 60; % cm
ancho_pasillo = 90; % cm
lenght_estante_stack = 200;  % cm
alto_pasillo_intermedio = 80; % cm

num_estantes = 5; 
num_filas = 2; 
num_estantes_total = num_estantes  * num_filas; 

% Definiciones primitivas
estante = ones(lenght_estante_stack, ancho_estante); 
pasillo = zeros(lenght_estante_stack , ancho_pasillo); 

filas_estantes = []; 
stack = [pasillo, estante]; 
for i = 1:num_estantes
    filas_estantes = [filas_estantes , stack]; 
end 
filas_estantes = [filas_estantes, pasillo]; 
filas_estantes_con_pasillo_intermedio = [filas_estantes; zeros(alto_pasillo_intermedio, size(filas_estantes, 2))]; 


p = zeros(80, size(filas_estantes, 2)); 

for i = 1:num_filas
    p = [p; filas_estantes_con_pasillo_intermedio]; 
end 

map = binaryOccupancyMap(p, 100);
show(map); 

%% Grafo de conexión 
waypoints = zeros(num_filas * num_estantes * 3, 2); 
count = 0; 
for k = 0: num_estantes * num_filas - 1
    fila = floor(k/num_estantes); 
    columna = mod(k, num_estantes); 
    disp("k: "  + num2str(k) + " fila: " + num2str(fila) + " , columna: " + num2str(columna) );

    qy = alto_pasillo_intermedio + 0.5 * (lenght_estante_stack) + (fila ) * (lenght_estante_stack + alto_pasillo_intermedio); 
    qx = 0.5 * ancho_pasillo + (columna) * (ancho_pasillo + ancho_estante); 

    waypoints((k * 3) + 1, :) = [qx, qy - lenght_estante_stack * 0.5]; 
    waypoints((k * 3) + 2, :) = [qx, qy]; 
    waypoints((k * 3) + 3, :) = [qx, qy + lenght_estante_stack * 0.5]; 
    
        
    % superior e inferior 
end 
waypoints = waypoints / 100;

show(map); 
hold on; 

% Plot cada segmento 
for k = 1:num_estantes * num_filas
   % plot(waypoints(1 + 3 * (k - 1):3*(k), 1),waypoints(1 + 3 * (k - 1):3*(k), 2), "b-o")
    hold on; 
end 
title("Disposición de waypoints en biblioteca"); 
xlabel("x [metros]"); 
ylabel("y [metros]"); 


% legend("Waypoints"); 

%% Representación con grafos 
path = graph; 
adj_mat = zeros(num_estantes_total * 3); 

for i = 1:(3 * num_estantes_total)
    % Conexiones por estantería 
    if mod(i, 3) ~= 0
        adj_mat(i, i + 1) = 1; 
    end 

    % Conexiones entre estanterías
    if  mod(i + 1, 3) ~= 0  && i < 3 * num_estantes_total - 2 && abs(i - (3 * num_estantes_total)/2 + 1 ) > 1
        adj_mat(i, i + 3) = 1; 
    end 
end 

adj_mat;

% Tunear los nodos 
G = graph(adj_mat,"upper");


for i = 1:num_estantes
    for j = 1:num_estantes
        nodo_base = 3*i; 
        nodo_objetivo = num_estantes * 3 + 3 * (j - 1) + 1; 

        nodo_base

        G = G.addedge(nodo_base,nodo_objetivo, 1);
    end 
end 

G.Nodes.Names = cellstr(string(1:num_estantes_total*3))'; 

% Trancisión entre estantes 

hold on; 
plot(G,'NodeLabel',G.Nodes.Names, 'XData',waypoints(:, 1), 'YData',waypoints(:, 2))
hold off; 
legend("Trayectoria")



%% Guardarlo 
save("occupancy_map_bib" , "map", "waypoints", "G")

