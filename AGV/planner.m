function [traj] = planner(map, G, waypoints, pi, pf)
%PLANNER Arroja la trayectoria de movimiento entre puntos basado en el
%plano
       
    A = adjacency(G); 
    [e, L] = dijkstra(A, pf, pi); 
    
    s = L(1:end - 1); 
    t = L(2:end); 
    p = plot(G,'NodeLabel',G.Nodes.Names, 'XData',waypoints(:, 1), 'YData',waypoints(:, 2));
    highlight(p,s, t,'EdgeColor','r','LineWidth',1.5); 
    highlight(p, [pi, pf], 'NodeColor','red', 'MarkerSize', 5)
    
    
    
    N = length(L); 
    id_transicion = []; 
    traj = zeros(1, 2)
    
    for waypoint_id = 1:N-1
        % Id en grafo de cada punto
        pid_i = L(waypoint_id); 
        pid_ii = L(waypoint_id + 1); 
    
        % (x,y) de cada Punto 
        p_i = waypoints(pid_i, :);
        p_ii = waypoints(pid_ii, :);
        
        % Métricas de comparación @see /utilities
        S = dist(p_i, p_ii);
        phi = angle(p_ii, p_i); 
    
           
        if abs(phi - 3.1415/2) >= 0.1
            traj = [traj; arc_path([p_i; p_ii])]; 
        else
            dy = linspace(p_i(2), p_ii(2), 100)
            dx = p_i(1) * ones(1, 100);
            traj = [traj; [dx', dy']];
        end 
    end 
    
    show(map)
    hold on; 
    p = plot(G,'NodeLabel',G.Nodes.Names, 'XData',waypoints(:, 1), 'YData',waypoints(:, 2));
    
    hold on; 
    plot(traj(2:end, 1), traj(2:end, 2), 'LineWidth', 1.4);
    hold off; 
end

