function res = setSteering(angle_deg)
   
    if(angle_deg == 0)
        val = 150; 
    elseif( angle_deg > 0 && angle_deg < 25.7831) % maximum steering radius is 25.7 degrees = 0.45 rad
        val = 150+ angle_deg*1.9393; %1.9393 = 50/25.7831
    elseif( angle_deg < 0 && angle_deg > -25.7831)
        val = 150 + (angle_deg*1.9393); 
    else 
        res = 0;
        return;
    end 
    val = round(val); 
    str = "D" + val; %sprintf("D%d",val);
    str = convertStringsToChars(str) ;  
    EPOCommunications('transmit',str); 
    
end 
    