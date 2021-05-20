function [yaw,D ] = rotate_car(yaw_car, dPhi,stearing_angle,L)

    D = [cos(yaw_car)  sin(yaw_car) 0;
         -sin(yaw_car) cos(yaw_car) 0;
         0             0            1];
    R = L/sin(stearing_angle); 
    if(stearing_angle < 0)
        dPhi = -dPhi;
    end    
    Steering_matrix = [
        cos(dPhi) -sin(dPhi) R*( cos(yaw_car) - cos(dPhi-yaw_car));
        sin(dPhi) cos(dPhi)  -R*(sin(yaw_car) -sin(dPhi-yaw_car));
        0                    0                    1           
        ];
    
    D = Steering_matrix * D; 
    D = [D(1,1) D(1,2); D(2,1) D(2,2)];
    yaw = dPhi + yaw_car;
end