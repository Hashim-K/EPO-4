function path = challenge_A_routing(start, endpos, radius, direction)
% Function used to make a routing for challenge A
% input are the start and stop location, and the turn radius of the car
% 4th input is the direction. The car points to this side at the beginning.
% it can hold the value: 0,90,180,270 degrees. 
% Where 0 degrees points to the right and 90 to the top 

    if(direction == 0) %make waypoint in direction such that car will point correctly at beginning
        waypoint = [start(1)+20,start(2)] %a point is generated 20cm to the wanted direction
    elseif(direction == 180)
        waypoint = [start(1)-20,start(2)]
    elseif(direction == 90)
        waypoint = [start(1), start(2)+20]
    elseif(direction == 270)
        waypoint = [start(1), start(2)-20]
    end
    
    
    path = routing(radius, waypoint, start, endpos); %using the route function to generate the path

    

end
