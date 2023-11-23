function [S] = dist(v1, v2)
 dx = v1(1) - v2(1); 
 dy = v1(2) - v2(2); 

 S = sqrt(dx^2 + dy^2); 
end

