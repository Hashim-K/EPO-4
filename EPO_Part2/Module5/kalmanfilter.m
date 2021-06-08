%% function [X_est,P_est, x_pred] = kalman_filter(X,Y,P,Fx,Fy,dt,sigma)
%    X_est - returns the estimated x,y,vx and vy 
%    P_est - returns the estimated Covariance matrix 
%
%    X is the current state of the x,y,vx and vy
%    Y is the measurement of the x and y coordinate
%    P is the current covariacne matrix 
%    Fa is the applied force to the system
%    dt is the elapsed time between the last update
%    sigma is the normalized noise power 
%%
 
function [X_est,P_est,x_pred] = kalman_filter(X,Y,P,Fx,Fy,dt,sigma)
    %Comptute the a matrix 
    A = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1 ];
    %compute the B matrix 
    B = [0.5*dt^2 0; 0 0.5*dt^2; dt 0; 0 dt; ];
    %compute the process noise matrix
    Q = [dt^4/4 0 dt^3/2 0; 0 dt^4/4 0 dt^3/2;  dt^3/2 0 dt^2 0; 0 dt^3/2 0 dt^2];
    
    %sensor noise 
    R = [sigma^2 0;
      0       sigma^2];
    %Observation thingy
    C = [1 0 0 0;
      0 1 0 0];
  
    %Make prediction using simple  uniform motion
    x_pred = A*X + B*[Fx;Fy];
    
    %Make prediction of the covariance matrix 
    P_pred = A*P*A' + Q; 
    
    y_est = Y - C*x_pred; 
    
    %Kalman gain
    K = P_pred*C'/(C*P_pred*C' + R);
    
    %Do the estimation
    X_est = x_pred + K*y_est;
    P_est = (eye(4)-K*C)*P_pred;
end

 