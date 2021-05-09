classdef model < handle
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        time
        force
        angle
        VectorX % VectorX(1)= posX, VectorX(2)=velocityX
        VectorY % VectorY(1)= posY, VectorY(2)=velocityY 
        status % -1 = crash, 0 = off, 1 = on, 2 = success
        debug
    end
    
    methods
        %constructor
	function obj = model(x,f,alpha)
	    % constructor (same name as class); returns initialized object
	    if nargin == 0
            % if no input arguments
	        x = [0,0];
            f=0;
            alpha=90;
	    end	
        obj.VectorX=[x(1), 0];
        obj.VectorY=[x(2), 0];
        obj.angle=alpha;
        obj.force=f;
        obj.status=0;
        obj.time=tic;
        obj.debug=0;
    end

    %display method
	function disp(obj)
	    % disp prints the object's values
        statustext=["crash", "off", "on", "success"];
        if obj.debug == 1
            disp("Display method is active")
        end
        Vx=obj.VectorX;
        Vy=obj.VectorY;
	    t0 = obj.time;
        f = obj.force;
        alpha=obj.angle;
        tspan=toc(t0);
        if(obj.status~=-1 && ((Vx(end,1) > 6 || Vx(end,1) < 0) || ( Vy(end,1) > 6 || Vy(end,1)  < 0))  )
            disp("CRASH")
            obj.status=-1;	
            Vx(end,2)=0;
            Vy(end,2)=0;
            obj.force=0;
        end
        stat = obj.status;
        if stat == 1
            [t,Vx] = ode45(@(t,vector) motion_ode(t, vector, f*cosd(alpha) ), [0 tspan], [Vx(1);Vx(2)]);
            [t,Vy] = ode45(@(t,vector) motion_ode(t, vector, f*sind(alpha) ), [0 tspan], [Vy(1);Vy(2)]);
        end
        
        obj.VectorX=[Vx(end,1),Vx(end,2)];
        obj.VectorY=[Vy(end,1),Vy(end,2)];
	    disp("position-x: " + Vx(end,1)+" position-y: " + Vy(end,1));
        disp("velocity-x: " + Vx(end,2)+" velocity-y: " + Vy(end,2));
        disp("status: " + statustext(stat+2));
        disp("Force: " + f);
	    disp("time since last update: "+tspan);
        obj.time=tic;
    end
    
    %set methods    
    function obj = set.force(obj,f)
        if obj.debug == 1
            disp("set Force");
        end
        if obj.status == -1
            obj.force=0;
        else
            obj.force = f;
        end
    end
    
    function obj = set.angle(obj,alpha)
        if obj.debug == 1
            disp("set Angle"); 
        end
        if obj.status == -1
            obj.angle=0;
        else
            obj.angle = alpha;
        end
    end
    
    function obj = set.VectorX(obj,Vx)
        if obj.debug == 1
            disp("set Vector X"); 
        end
	    obj.VectorX = Vx;
    end
    
    function obj = set.VectorY(obj,Vy)
        if obj.debug == 1
            disp("set Vector Y");
        end
	    obj.VectorY = Vy;
    end
    
    function obj = set.status(obj,stat)
        if obj.debug == 1
            disp("set Status");
        end
        obj.status = stat;
    end
    
    function obj = set.time(obj,t)
        if obj.debug == 1
            disp("set Time"); 
        end
        obj.time = tic;
    end
    
    %get methods
    function f = get.force(obj)
        if obj.debug == 1
            disp("get Force"); 
        end
        f = obj.force;
    end
    
    function alpha = get.angle(obj)
        if obj.debug == 1
            disp("get Angle");
        end
        alpha = obj.angle;
    end
    
    function Vx = get.VectorX(obj)
        if obj.debug == 1
            disp("get Vector X"); 
        end
        Vx = obj.VectorX;
    end
    
    function Vy = get.VectorY(obj)
        if obj.debug == 1
            disp("get Vector Y");
        end
        Vy = obj.VectorY;
    end
    
    function stat = get.status(obj)
        if obj.debug == 1
            disp("get Status");
        end
        stat = obj.status;
    end
    
    function t = get.time(obj)
        if obj.debug == 1
            disp("get Time");
        end
        t = obj.time;
    end
    
end
end


