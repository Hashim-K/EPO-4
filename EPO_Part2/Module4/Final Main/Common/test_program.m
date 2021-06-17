clc;
load("H:\My Documents\EPO-4\EPO_Part2\Module4\Final_recording_mic.mat");
Port ='\\.\COM15';

result = EPOCommunications('open',Port);
EPOCommunications('transmit','S'); 
EPOCommunications('transmit','B15000'); % set the bit frequency
EPOCommunications('transmit','F5000');% set the carrier frequency
EPOCommunications('transmit','R2500'); % set the repetition count
EPOCommunications('transmit','C0x50f1072b'); % set the audio cod

p = [0 0 471 471 233 ; 0 473 473 0 0 ; 24 24 24 24 54 ];

%x = x(8000:10000);

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

position = [0,0];

i = 0;
k_t = 0;
k_d = 1;

g1 = plot(position(1), position(2),'gx');
g2 = plot(path(1,1), path(2,1),'gx');
data = [0, 0];
old_data = [20,20];
while(i < 500)
i = i + 1;


    % LABEL again
    
    %pause(0.5)
    %data2 =   get_pos(x,p);
    old_data = data;
    n=1;
    
   
    data1 = get_pos(x,p)
 
    
   while((sqrt((data1(1) - old_data(1))^2 + (data1(2) - old_data(2))^2  )> 90) && n<10 )
            data1 = get_pos(x,p)
             n=n+1
             disp("in whil")
   end
    data(1) = (data1(1));%+data2(1))/2;
    data(2) = (data1(2));%+data2(2))/2;

position = data;
[n, distance_to_path] = closest_point(position, path);
delete(g1)
delete(g2)

g1 = plot(position(1), position(2),'ro');
g2 = plot(path(1,n), path(2,n),'go');

theta_path = path(3,n);
theta_rover = car_angle(old_data, data)
theta_rover = theta_path;
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
steering = k_t*(theta_path - theta_rover) + k_d*a*distance_to_path;
if(steering > 22)
    steering = 22;
end
if(steering < -22)
    steering = -22;
end

setSteering(steering);


%bang bang controller
[distance_waypoint, distance_endpoint] = arclength(position, path);



force = 10; %force without braking
setMotorSpeed(force);
pause(0.45)

% if(passed_waypoint == 1)
%     distance_waypoint = 0;
% end
% if(distance_waypoint ~= 0) %distance is zero when car passed waypoint
%     if(distance_waypoint < 30) %remmen, simpel voor nu
%         force = 0
%         setMotorSpeed(force);
%         passed_waypoint = 1;
%         pause(5) %wait for standing still and measuring
%         
%     end
% else
%     if(distance_endpoint < 30)
%         force = 0
%         setMotorSpeed(force); %end of programm
%         pause(5)
%     end
% end

setMotorSpeed(0);
pause(0.8)

end
result = EPOCommunications('close');

            %plot(app.UIAxes,waypoints(3,1),waypoints(3,2),'r+')