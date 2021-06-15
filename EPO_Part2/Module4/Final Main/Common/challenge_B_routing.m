function path = challenge_B_routing(start, waypoint, endpos, radius, direction)
    %turn radius of car = 115
    
    path1 = challenge_A_routing(start, waypoint, radius, direction)
    
    wx1 = path1(1,end-1)
    wy1 = path1(2,end-1)
    wx2 = path1(1,end-2)
    wy2 = path1(2,end-2)
    
    waypoint1 = [wx1 + (wx1-wx2)*20, wy1 + (wy1-wy2)*20] %making a point along the first path to make the routing possible
    
    path2 = routing(radius, waypoint1, waypoint, endpos)
    
    path(1,:) = [path1(1,:) path2(1,:)];
    path(2,:) = [path1(2,:) path2(2,:)];
    path(3,:) = [path1(3,:) path2(3,:)];
    
    x_coor = path(1,:);
y_coor = path(2,:);
plot(x_coor,y_coor)
            xlim([0, 600])
            ylim([0, 600])




end
