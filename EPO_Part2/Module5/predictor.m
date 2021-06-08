
function [x_pred ] = predictor(X,dt,Fx,Fy)
 %Comptute the a matrix 
    A = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1 ];
    %compute the B matrix 
    B = [0.5*dt^2 0; 0 0.5*dt^2; dt 0; 0 dt; ];
    
    x_pred = A*X + B*[Fx;Fy];
end 