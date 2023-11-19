% Creacion de mapa de ocupacion binario 
clear; clc; close all; 
lenght_estante_stack = 200; 
estante = ones(lenght_estante_stack, 60); 
pasillo = zeros(lenght_estante_stack , 90); 
filas_estantes = [pasillo, estante, pasillo, estante, pasillo, estante, pasillo,estante, pasillo]; 


filas_estantes_con_pasillo_intermedio = [filas_estantes; zeros(80, size(filas_estantes, 2))]; 

p = [ zeros(80, size(filas_estantes, 2)); filas_estantes_con_pasillo_intermedio; filas_estantes_con_pasillo_intermedio;  zeros(80, size(filas_estantes, 2)) ];

map = binaryOccupancyMap(p, 100);
show(map); 

%% Guardarlo 
save("occupancy_map_bib" , "map")

