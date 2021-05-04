vref = 20; %km/h

v = vref/3.6; %m/s


output = sim('car_model','StartTime','0','StopTime','8','FixedStep','0.01');

plot(output.v.time, output.v.signals.values);
title('Velocity of the car');
xlabel('time [s]') 
ylabel('velocity [m/s]') 

i = 1;
while(output.v.signals.values(i,1) < v) %searching untill velocity is more then v
    i = i+1;
end
disp("Time untill velocity is more than " + vref + " km/h: " + output.v.time(i,1) + "s"); %plot velocity