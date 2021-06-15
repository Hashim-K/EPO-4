function angle = car_angle(data1, data2)


    dy = (data2(2) - data1(2));
    dx = (data2(1) - data1(1));
    angle1 = dy / dx;
    
    angle1 = atan(angle1);
    
    if(dx < 0) %calculating angle also for second and third quadrant.
        angle1 = angle1 + pi;
    elseif(dy < 0) %calculating also for 4th quadrant
        angle1 = angle1 + 2*pi;
    end
    angle = angle1*180/pi;


end