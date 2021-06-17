function [x_new, y_new, angle_new,angle_new_perp] = predictor(x_old ,y_old ,angle_old ,steering,step_distance)
     
     %when the steering angle is zero we move in a straight line governed
     %by the current angle of the car 
     if(steering == 0)
         
         angle_new = angle_old;
         x_new = x_old + step_distance* cos(angle_new+1/2*pi); 
         y_new = y_old + step_distance* sin(angle_new+1/2*pi); 
     else
         %Calculate Steering radius 
         R = sqrt( (0.335/tan(abs(steering)) + 0.415/2)^2+(0.417/2)^2);

         %Calculate circumference of the circle the car makes when steering
         circum = 2*pi*R;

         %Calculate angle the car makes
         d_angle = step_distance/circum*2*pi;
         
         %when steering to the left we move clockwise around the circle
         %with radius R. When to the right we are heading counter clockwise
         if(steering > 0)
               
             dx = R*(cos(d_angle+angle_old)-cos(angle_old));
             dy = R*(sin(d_angle+angle_old)-sin(angle_old));
             angle_new = angle_old + d_angle; 
         else
             d_angle = d_angle * -1;
             dx = R*(cos(d_angle+angle_old+pi)-cos(angle_old+pi));
             dy = R*(sin(d_angle+angle_old+pi)-sin(angle_old+pi));
             angle_new = angle_old + d_angle;
         end
             
             x_new = x_old + dx;
             y_new = y_old + dy;
         
     end 
     angle_new_perp = angle_new + 1/2 *pi;
end