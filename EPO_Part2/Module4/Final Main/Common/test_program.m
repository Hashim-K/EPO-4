clc;
load("H:\My Documents\EPO-4\EPO_Part2\Module4\Final_recording_mic.mat");
Port ='\\.\COM15';

result = EPOCommunications('open',Port);
EPOCommunications('transmit','S'); 
EPOCommunications('transmit','B15000'); % set the bit frequency
EPOCommunications('transmit','F5000');% set the carrier frequency
EPOCommunications('transmit','R2500'); % set the repetition count
EPOCommunications('transmit','C0x50f1072b'); % set the audio cod
clf;
p = [0 0 471 471 233 ; 0 473 473 0 0 ; 24 24 24 24 54 ];

%x = x(8000:10000);

radius = 120;
waypoint_1 = [250,100];
start = [400,100];
endpoint = [100,400];
direction = 90;

path = challenge_A_routing(start, endpoint, radius, direction)
challenge = 1;%1 is challenge A, 2 is B


passed_waypoint = 0;

x_coor = path(1,:);
y_coor = path(2,:);
plot(x_coor,y_coor)
            xlim([0, 475])
            ylim([0, 475])
hold on;
plot(waypoint_1(1), waypoint_1(2),'r+');

position = [0,0];

i = 0;
k_t = 0;
k_d = 1;

g1 = plot(position(1), position(2),'gx');
g2 = plot(path(1,1), path(2,1),'gx');
data = [0, 0];


old_data = start;
data = start;
angle_pred = 0; 
while(i < 500)
i = i + 1;


    % LABEL again
    
    %pause(0.5)
    %data2 =   get_pos(x,p);
    
    n=1;
    
   
    data1 = get_pos(x,p)
    

   while((sqrt((data1(1) - old_data(1))^2 + (data1(2) - old_data(2))^2  )> 50) && n<5 )
            data1 = get_pos(x,p)
             n=n+1
                  
             disp("in whil")
   end
   
    old_data_twice = data;
    data(1) = (data1(1));%+data2(1))/2;
    data(2) = (data1(2));%+data2(2))/2;
    old_data = data;
    
    stopping_radius = 30;
    
    if((data(1) - endpoint(1))^2 + (data(2) - endpoint(2))^2 < stopping_radius^2)
        setMotorSpeed(0);
        disp("final point reached");
        pause(40);
    end
    
    if((data(1) - waypoint_1(1))^2 + (data(2) - waypoint_1(2))^2 < stopping_radius^2)
        setMotorSpeed(0);
        disp("waypoint reached");
        pause(30);
    end
    
    
    
    
    
    
    
position = data;
[n, distance_to_path] = closest_point(position, path);
delete(g1)
delete(g2)

g1 = plot(position(1), position(2),'ro');
g2 = plot(path(1,n), path(2,n),'go');

theta_path = path(3,n);

theta_rover = car_angle(old_data_twice, data)
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
steering = k_t*(theta_path - theta_rover) + k_d*a*distance_to_path^2;
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
pause(0.4)

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

%[x_new, y_new, angle_pred] = predictor(old_data_twice(1) ,old_data_twice(2) ,angle_pred ,deg2rad(steering),0.4);
%x_new = x_new*100; 
%y_new = y_new *100; 
 %plot(x_new, y_new,'bx');
setMotorSpeed(0);
pause(0.8)

end
result = EPOCommunications('close');

            %plot(app.UIAxes,waypoints(3,1),waypoints(3,2),'r+')