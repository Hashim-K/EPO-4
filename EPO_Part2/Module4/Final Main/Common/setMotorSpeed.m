function res = setMotorSpeed(force)
    val = 0 ;
    if(force == 0)
        val = 150; 
    elseif( force > 0 && force < 16)
        val = 150+force;
    elseif( force < 0 && force > -16)
        val = 150 + force; 
    else 
        res = 0;
        return;
    end 
    str = convertStringsToChars("M" + val);
    EPOCommunications('transmit',str); 
    
end 
    