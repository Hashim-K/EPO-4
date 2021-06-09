clear all;
m = 5.6;
b = 5;
dT = 0.5;
theta_car = 90*pi/180;
A = [1 0 (dT - (dT^2*b)/(2*m))*cos(theta_car);...
    0 1 (dT - (dT^2*b)/(2*m))*sin(theta_car); ...
    0 0 (1 - (dT*b)/(m))];
B = [(dT^2)/(2); (dT^2)/(2); (dT/m)];
C = [1 0 0;
    0 1 0];
R = 0.02;
Q = 0.05;
Fa = 10;

D = 0;

Plant = ss(A,B,C,D,-1);
Plant.InputName = 'un';
Plant.OutputName = 'yt';

Sum = sumblk('un = u + w');
sys = connect(Plant,Sum,{'u','w'},'yt');

N = 0;

[kalmf,L,P] = kalman(sys,Q,R,N);

% current_pos = [367; 341];
% 
% yk = [current_pos; 1];
% uk = Fa;
% x_start = [100; 1; 0];
% 
% Pk_min = Q;
% xk_min = A*x_start + B*uk;
% 
% Kk = (Pk_min*C')/(C*Pk_min*C' + R);
% xk = xk_min + Kk*(yk - C*xk_min);
% Pk = (eye(3) - Kk*C)*Pk_min;
