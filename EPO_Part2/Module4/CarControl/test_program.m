kitt = EPOCommunications('open','P'); % create kitt! now in public mo


waypoints = [0 0; ...
	100 100; ...
	200 400; ...
	600 400];
refPath = referencePathFrenet(waypoints);
connector = trajectoryGeneratorFrenet(refPath);

initState = [0 0 0 0 0 0];  % [S ds ddS L dL ddL]
termState = [1000 0 0 0 0 0]; % [S ds ddS L dL ddL]
[~,trajGlobal] = connect(connector,initState,termState,5);

% show(refPath);
% hold on
% axis equal

% plot(trajGlobal.Trajectory(:,1),trajGlobal.Trajectory(:,2),'b')
% legend(["Waypoints","Reference Path","Trajectory to 30m"])

x_coor = trajGlobal.Trajectory(:,1);
y_coor = trajGlobal.Trajectory(:,2);
plot(x_coor,y_coor)
            xlim([0, 600])
            ylim([0, 600])
hold on;

position = [0,0]

g1 = plot(pathPoints(1), pathPoints(2),'r+');
g2 = plot(points(1), points(2),'rx');

i = 0;
k_t = 1;
k_d = 0.001;

while(i < 10)
i = i + 1
position = [i,i]
pathPoints = closestPoint(refPath,position)
delete(g1)
delete(g2)
g1 = plot(pathPoints(1), pathPoints(2),'r+');
g2 = plot(position(1), position(2),'rx');
theta_path = pathPoints(3)/pi*180;
theta_rover = 45;

distance_to_path = sqrt((pathPoints(1) - position(1))^2+(pathPoints(2) - position(2))^2);
if(theta_rover^2 < 90^2) %if rover is looking towards right half plane
    if(position(2) < pathPoints(2)) %then if rover is beneath path steer to left
        a = 1;
    else
        a = -1;
    end
else
    if(position(2) < pathPoints(2))
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
setSteering(steering);
force = 1;
setMotorSpeed(force);
pause(0.5)

end
            

            %plot(app.UIAxes,waypoints(3,1),waypoints(3,2),'r+')