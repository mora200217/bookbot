function [t] = arc(R, N, x0, y0, i, pc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % t = zeros(N, 2); 
    theta = linspace(0, 3.14/2, N) + i * 3.14/2; 
    
    t = [x0 + R*cos(theta)' , y0 + R*sin(theta)'] ;
    t = t + ones(size(t , 1), 1) * R * pc
    
    % Correcion de 0
    % phi = i * 3.14/2;
    % t = t + (R * [cos(phi) -sin(phi); sin(phi) cos(phi)] * [-ones(1, N) ; zeros(1, N)])';


end

