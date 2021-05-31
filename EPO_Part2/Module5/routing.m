
waypoints = [0 0; ...
	50 20; ...
	100 0; ...
	150 10];
refPath = referencePathFrenet(waypoints);
connector = trajectoryGeneratorFrenet(refPath);

initState = [0 0 0 0 0 0];  % [S ds ddS L dL ddL]
termState = [190 0 0 0 0 0]; % [S ds ddS L dL ddL]
[~,trajGlobal] = connect(connector,initState,termState,5);

% show(refPath);
% hold on
% axis equal

% plot(trajGlobal.Trajectory(:,1),trajGlobal.Trajectory(:,2),'b')
% legend(["Waypoints","Reference Path","Trajectory to 30m"])

x_coor = trajGlobal.Trajectory(:,1);
y_coor = trajGlobal.Trajectory(:,2);
plot(x_coor,y_coor)

