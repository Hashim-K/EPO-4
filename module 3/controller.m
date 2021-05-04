b = 5;
c = 0.1;
m = 5.6;
Fai = 10;
Fbi = 10;
distance = 6;


Fa = Fai;
Fb = 0;
v0 = 0;
s0 = 0;
output = sim('KITTDynamicsFinal','StartTime','0','StopTime','6','FixedStep','0.01');


Fa = 0;
Fb = Fbi;

s = 0;
v0 = 1;
while(s < distance - 0.01)%find fit to position
    i = 1;
    output1 = sim('KITTDynamicsFinal','StartTime','0','StopTime','8','FixedStep','0.01');
    while(output1.v.signals.values(i,1) > 0.01) %searching untill velocity is more then v
        i = i+1;
    end
    disp(i);
    
    s = output1.s.signals.values(i-1,1);
    v0 = v0 + (distance - s)*0.7;

plot(output1.s.signals.values, output1.v.signals.values);
hold on;
end


plot(output.s.signals.values, output.v.signals.values);
hold on;
plot(output1.s.signals.values, output1.v.signals.values);
title('Velocity of the car');
xlabel('Distance [m]') 
ylabel('velocity [m/s]') 
hold off;
[x_stop,v_max] = polyxpoly(output.s.signals.values, output.v.signals.values,output1.s.signals.values, output1.v.signals.values)
i = 1;


while(output.v.signals.values(i,1) < vref) %searching untill velocity is more then v
    i = i+1;
end

stop_t = output.v.time(i-1,1)


