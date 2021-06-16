function [min_i, min] = closest_point(point, path)
%function to determine closest point from a path 
min = 999999999999;
min_i = 0;
for i = 1:length(path)
    d = sqrt((point(1) - path(1,i))^2 + (point(2) - path(2,i))^2);
    if(d < min)
        min = d;
        min_i = i;
    end
end
%out = [min_i, min];
end