classdef car_model  < handle
    properties 
        Fa = 0;
           m = 5.6; %kg
        b = 5; %Nm/s
        c = 0.1; %Nm/s^2
        local_time;
        start_time 
        y = [];
        t = [];
        tspan = [0 100];
        ode_length =0;

    end   
    methods
        function disp(obj) 
            x = obj.get_pos(); 
            velocity = obj.get_velocity();
            total_time = obj.get_total_time(); 
            update_time = obj.get_update_time();
            
            disp("Position = " + x);
            disp("Velocity = " + velocity); 
            disp("Total time = " + total_time); 
            disp("Update time = " + update_time); 

        end 
        function obj =init(obj,x_pos)
            obj.local_time = get_time();
            obj.start_time = get_time(); 
            y0 = [x_pos 0];         % intial conditions 
            [obj.t,obj.y] = ode45(@(t,y) motion_ode(t,y,obj.Fa), obj.tspan, y0);
            obj.ode_length= length(obj.t);
            plot(obj.t,obj.y);
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
           plot(obj.t,obj.y);
        end 
        
        function x = get_pos(obj) 
            dt = get_time()-obj.local_time;
            [c index] = min(abs(obj.t-dt));
            x = obj.y(index,1); 
        end 
        
        function v = get_velocity(obj) 
            dt = get_time()-obj.local_time
            [c index] = min(abs(obj.t-dt));
            v = obj.y(index,2); 
        end
        
        function t = get_total_time(obj)
            t = get_time() - obj.start_time;
        end 
        
        function t = get_update_time(obj)
            t = get_time() - obj.local_time;
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