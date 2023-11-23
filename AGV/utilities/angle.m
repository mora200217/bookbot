function [phi] = untitled(v1,v2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dx = v1(1) - v2(1) ; 
dy = v1(2) - v2(2) ; 

phi = atan2(dy, dx); 
end

