radius = 70;
waypoint_1 = [250,100];
start = [0,0];
endpoint = [500,400];


path = routing(radius, waypoint_1, start, endpoint);

passed_waypoint = 0;

x_coor = path(1,:);
y_coor = path(2,:);
plot(x_coor,y_coor)
            xlim([0, 600])
            ylim([0, 600])
hold on;
plot(waypoint_1(1), waypoint_1(2),'r+');

position = [0,0]

i = 0;
k_t = 1;
k_d = 0.001;

g1 = plot(position(1), position(2),'gx');
g2 = plot(path(1,1), path(2,1),'gx');


while(i < 500)
i = i + 1
position = [i,i]
[n, distance_to_path] = closest_point(position, path)
delete(g1)
delete(g2)

g1 = plot(position(1), position(2),'gx');
g2 = plot(path(1,n), path(2,n),'gx');

theta_path = path(3,n);
theta_rover = 45;

if(theta_rover^2 < 90^2) %if rover is looking towards right half plane
    if(position(2) < path(2,n)) %then if rover is beneath path steer to left
        a = 1;
    else
        a = -1;
    end
else
    if(position(2) < path(2,n))
        a = -1;
    else
        a = 1;
    end
end
steering = k_t*(theta_path - theta_rover) + k_d*a*distance_to_path^2;
if(steering > 45)
    steering = 45;
end
if(steering < -45)
    steering = -45;
end
steering
%setSteering(steering);


%bang bang controller
[distance_waypoint distance_endpoint] = arclength(position, path)

force = 7.5 %force without braking
if(passed_waypoint == 1)
    distance_waypoint = 0;
end
if(distance_waypoint ~= 0) %distance is zero when car passed waypoint
    if(distance_waypoint < 30) %remmen, simpel voor nu
        force = 0
        setMotorSpeed(force);
        passed_waypoint = 1;
        pause(5) %wait for standing still and measuring
        
    end
else
    if(distance_endpoint < 30)
        force = 0
        setMotorSpeed(force); %end of programm
        pause(5)
    end
end

setMotorSpeed(force);
pause(0.01)

end


            %plot(app.UIAxes,waypoints(3,1),waypoints(3,2),'r+')