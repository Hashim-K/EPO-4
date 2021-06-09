
function [x_pred ] = predictor(X,dt,Fx,Fy)
   %Define car parameters here 
    b = 5;
    m = 5.6;
    
    vx = X(3); vy = X(4);
    Fx = Fx/m;
    Fy = Fy/m; 
    %Comptute the a matrix 
    A = [1 0 dt*(1-dt*(b*vx)/(2*m)) 0;
         0 1 0 dt*(1-dt*(b*vy)/(2*m)); 
         0 0 (1 - dt*(b*vx)/m) 0; 
         0 0 0 (1 - dt*(b*vy)/m) ];
    %compute the B matrix 
    B = [0.5*dt^2 0; 
         0 0.5*dt^2; 
         dt  0; 
         0 dt ];
     
     
    x_pred = A*X + B*[Fx;Fy];
end 