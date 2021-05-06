clear;clc;
hold on ;
car = car_model;
car.init(500);
y = car.y;
pause(1);
v = car.get_velocity()
car.set_force(10);
y = car.y;
t = car.t;
pause(1);
v = car.get_velocity()
pause(0.5);
v = car.get_velocity()
pause(0.5);
v = car.get_velocity()