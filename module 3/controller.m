function [distance_to_wall, stop_t, v_max] = controller(Fai, Fbi, distance, timer_period, margin)



b = 5; %the constants for the friction and mass
c = 0.1;
m = 5.6;


Fa = Fai; %settting initial conditions for maximum accelerating from start
Fb = 0;
v0 = 0;
s0 = 0;
output = sim('KITTDynamicsFinal', 'StartTime','0','StopTime','8','FixedStep','0.005', 'SrcWorkspace','current');


Fa = 0; %setting initial conditions for maximum braking
Fb = Fbi;

s = 0;
v0 = 0.1;
while(s < distance - 0.004)%find fit to position
    i = 1;
    output1 = sim('KITTDynamicsFinal', 'StartTime','0','StopTime','8','FixedStep','0.005', 'SrcWorkspace','current');
    while(output1.v.signals.values(i,1) > 0.01) %searching untill velocity is more then v
        i = i+1;
    end
    
    s = output1.s.signals.values(i,1); %look for intersection with x-axis
    v0 = v0 + (distance - s)*0.6; %increase v0 for next iteration

plot(output1.s.signals.values, output1.v.signals.values);
hold on;
end


plot(output.s.signals.values, output.v.signals.values); %plotting the last data of the iteration
hold on;
plot(output1.s.signals.values, output1.v.signals.values);
title('Velocity of the car');
xlabel('Distance [m]') 
ylabel('velocity [m/s]') 
hold off;
[x_stop,v_max] = polyxpoly(output.s.signals.values, output.v.signals.values,output1.s.signals.values, output1.v.signals.values);
i = 1;


while(output.v.signals.values(i,1) < v_max) %searching untill velocity is more then v
    i = i+1;
end

stop_t = output.v.time(i,1);

s = x_stop - v_max*0.05 - timer_period*v_max - margin; %correct for maximum sensor delay +setting force(50 ms * max velocity) and adda margin

distance_to_wall = 6 - s; %this is the correct coordinate system
end