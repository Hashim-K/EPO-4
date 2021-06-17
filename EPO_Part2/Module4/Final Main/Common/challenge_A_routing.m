function path = challenge_A_routing(start, endpos, radius, direction)
%direction = 0,90,180,270
    if(direction == 0)
        waypoint = [start(1)+40,start(2)]
    elseif(direction == 180)
        waypoint = [start(1)-40,start(2)]
    elseif(direction == 90)
        waypoint = [start(1), start(2)+40]
    elseif(direction == 270)
        waypoint = [start(1), start(2)-40]
    end
    
    
    path = routing(radius, waypoint, start, endpos);

    x_coor = path(1,:);
y_coor = path(2,:);
plot(x_coor,y_coor)
            xlim([0, 600])
            ylim([0, 600])
hold on;


end
