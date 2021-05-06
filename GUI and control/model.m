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
    end

    %display method
	function disp(obj)
	    % disp prints the object's values
        statustext=["crash", "off", "on", "success"];
        disp("Display method is active")
        Vx=obj.VectorX;
        Vy=obj.VectorY;
	    t0 = obj.time;
        f = obj.force;
        alpha=obj.angle;
        tspan=toc(t0);
        [t,Vecx] = ode45(@(t,vector) motion_ode(t, vector, f*cosd(alpha) ), [0 tspan], [Vx(1);Vx(2)]);
        [t,Vecy] = ode45(@(t,vector) motion_ode(t, vector, f*sind(alpha) ), [0 tspan], [Vy(1);Vy(2)]);
        if(obj.status~=-1 & (Vecx(end,1) > 600 | Vecx(end,1) < 0) & ( Vecy(end,1) > 600 | Vecy(end,1)  < 0))
                obj.status=-1;	
        end
        stat = obj.status;
        
        
        obj.VectorX=[Vecx(end,1),Vecx(end,2)];
        obj.VectorY=[Vecy(end,1),Vecy(end,2)];
	    disp("position-x: " + Vecx(end,1)+" position-y: " + Vecy(end,1));
        disp("velocity-x: " + Vecx(end,2)+" velocity-y: " + Vecy(end,2));
        disp("status: " + statustext(stat+2));
        disp("Force: " + f);
	    disp("time since last update: "+tspan);
        obj.time=tic;
    end
    
    %set methods    
    function obj = set.force(obj,f)
        disp("set Force");
	    obj.force = f;
    end
    
    function obj = set.angle(obj,alpha)
        disp("set Angle");
	    obj.angle = alpha;
    end
    
    function obj = set.VectorX(obj,Vx)
        disp("set Vector X");
	    obj.VectorX = Vx;
    end
    
    function obj = set.VectorY(obj,Vy)
        disp("set Vector Y");
	    obj.VectorY = Vy;
    end
    
    function obj = set.status(obj,stat)
	    disp("set Status");
        obj.status = stat;
    end
    
    function obj = set.time(obj,t)
	    disp("set Time");
        obj.time = tic;
    end
    
    %get methods
    function f = get.force(obj)
        disp("get Force");
            f = obj.force;
    end
    
    function alpha = get.angle(obj)
        disp("get Angle");
            alpha = obj.angle;
    end
    
    function Vx = get.VectorX(obj)
        disp("get Vector X");
            Vx = obj.VectorX;
    end
    
    function Vy = get.VectorY(obj)
        disp("get Vector Y");
            Vy = obj.VectorY;
    end
    
    function stat = get.status(obj)
        disp("get Status");
            stat = obj.status;
    end
    
    function t = get.time(obj)
        disp("get Time");
            t = obj.time;
    end
    
end
end


