 function dydt = motion_ode(t, y, Fa)
        m = 5.6; %kg
        b = 5; %Nm/s
        c = 0.1; %Nm/s^2
        sign_v = sign(y(2));
        dydt(1) = y(2);
        dydt(2) = 1/m * (Fa - (b*abs(y(2)) + c*y(2)^2)*sign_v);
        dydt = dydt';
    end