function [midp, endp] = arclength(point, path) %calculates distance to waypoints with given point and path
   [n,d] = closest_point(point, path)
    N = length(path)
    distance = 0;
    midp = 0
    endp = 0
    
    for i = n:N %waypoint always at i = 100, endpoint at N
        if(i <= 1)
            i=2;
        end
        distance = distance + sqrt( (path(1, i) - path(1,i-1))^2+(path(2,i) - path(2,i-1))^2)
        if (i == 100)
            midp = distance;
        elseif(i == N)
            endp = distance;
        end
    end
end