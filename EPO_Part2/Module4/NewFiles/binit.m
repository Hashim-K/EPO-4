function b = binit(Fs, F0, F1, C3, code)
    %Inputs are mic position matrix, car position vector, Freq0, Freq1,
    %Count3 and the code
    %Setting up the beacon
    b = beacon;
    if (Fs ~= -1)
        b.Fs = Fs;
    end
    if (F0 ~= -1)
        b.Freq0 = F0;
    end
    if (F1 ~= -1)
        b.Freq1 = F1;
    end
    if (C3 ~= -1)
        b.C3 = C3;
    end
    if (strcmp(code, "") == false)
        b.code = code;
    else
        b.code = "92340f0f";
    end
    b.button = true;
    
end