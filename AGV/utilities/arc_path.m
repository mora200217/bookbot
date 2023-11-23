function [traj] = arc_path(puntos)
%ARC_PATH Summary of this function goes here
%   Detailed explanation goes here
        L = 0.5 * abs(puntos(1, 2) - puntos(2, 2)); 
    
    
   plot(puntos(:, 1),puntos(:, 2), "--o"); % Distancias
    
    % Circular de salida 
    t1 = arc(L, 100, puntos(1, 1), puntos(1, 2), 0, [-1 0]);
    % Recto
    lx = (puntos(2, 1) - puntos(1, 1)) - sign(puntos(2, 1) - puntos(1, 1)) * 2 * L; 
    t2 = [(linspace(0, lx, 100) + t1(end, 1))', ones(size(t1, 1),1 ) * t1(end, 2)];
    % Circular de entrada 
    punto_final = puntos(end, :); 
    punto_incial = t2(end, :); 

    ang = rad2deg(angle(punto_final, punto_incial))
    t3 = arc(L, 100, punto_incial(1), punto_incial(2),2, [0, 1]);
    t3 = flip(t3)
    traj = [t1; t2; t3]; 
    plot(traj(:, 1), traj(:, 2))
end

