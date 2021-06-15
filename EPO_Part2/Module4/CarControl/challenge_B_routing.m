function path = challenge_B_routing(start, waypoint, endpos, radius, direction)
% Function used to make a routing for challenge B
% input are the start, waypoint and stop location, and the turn radius of the car
% 5th input is the direction. The car points to this side at the beginning.
% it can hold the value: 0,90,180,270 degrees. 
% Where 0 degrees points to the right and 90 to the top 
    

    %use challenge A to make path from start to first waypoint
    path1 = challenge_A_routing(start, waypoint, radius, direction);
    
    
    %calculate the direction of the car pointing after the first part (challenge A)
    
    wx1 = path1(1,end-1);
    wy1 = path1(2,end-1);
    wx2 = path1(1,end-2);
    wy2 = path1(2,end-2);
    
    %placing a waypoint along the line where the car is pointing to at the
    %waypoint.
    waypoint1 = [wx1 + (wx1-wx2)*20, wy1 + (wy1-wy2)*20]; %making a point along the first path to make the routing possible
    
    %generate a path from the waypoint to the final point.
    path2 = routing(radius, waypoint1, waypoint, endpos);
    
    path(1,:) = [path1(1,:) path2(1,:)]; %combining first and second path
    path(2,:) = [path1(2,:) path2(2,:)];
    path(3,:) = [path1(3,:) path2(3,:)];
    




end
