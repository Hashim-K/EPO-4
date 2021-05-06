classdef car_model  < handle
    properties 
        Fa = 0;
           m = 5.6; %kg
        b = 5; %Nm/s
        c = 0.1; %Nm/s^2
        local_time;
        y = [];
        t = [];
        tspan = [0 20];
        ode_length =0;
    end 
    methods
        
        function obj =init(obj )
            obj.local_time = get_time();
            y0 = [0 0];
            [obj.t,obj.y] = ode45(@(t,y) motion_ode(t,y,obj.Fa), obj.tspan, y0);
            obj.ode_length= length(obj.t);
        end
        function update_ode(obj) 
            x0 = obj.get_pos;
            x1 = obj.get_velocity; 
            y0 = [x0 x1];
            obj.local_time = get_time(); %becuase the differential equation is autonomous 
                              %we only need to keep track of the change in
                              %distance and the initial conditions, the
                              %absolute time is not relevant
            [obj.t,obj.y] = ode45(@(t,y) motion_ode(t,y,obj.Fa), obj.tspan, y0);
            obj.ode_length= length(obj.t);
           % plot(obj.t,obj.y)
        end 
        function x = get_pos(obj) 
            dt = get_time()-obj.local_time
            index = round(obj.ode_length/20 * dt)
            x = obj.y(index,2); 
        end 
        function v = get_velocity(obj) 
            dt = get_time()-obj.local_time
            index = round(length(obj.t)/20 * dt);
            v = obj.y(index,1); 
        end
        function set_force(obj,force)
            %Only when the force changes do we need to recompute the ode;
            if(force ~= obj.Fa) 
                obj.Fa = force;
                obj.update_ode(); 
            end 
        end       
    end  
end 