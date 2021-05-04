classdef car_model 
    properties
	%car properties
	position		% reference positionx at time t0
	velocity = [0,0];		% init value is needed!
    acceleration = [0,0];
    force = 150;
    vAngle = 0;
    angle = 90;%steering angle
    tStart = tic;  
	time = tic;
    status; % -1 = crash, 0 = off, 1 = on, 2=success
    end

    methods
        
    %constructor
	function obj = car_model(x,f,alpha)
	    % constructor (same name as class); returns initialized object
	    if nargin == 0
            % if no input arguments
	        x = [0,0];
            f=150;
            alpha=90;
	    end	
	    obj.position = x;   % (calls set.positionx; also starts timer)
        obj.acceleration = calcA(f,alpha);
        obj.angle=alpha;
        obj.force=f;
	    obj.velocity = [0,0];	% calls set.velocity (thus, init value needed)
        obj.status=0;
    end

    %display method
	function disp(obj)
	    % disp prints the object's values
	    % first update position based on current time and velocity
        global x
%         update(obj);
        statustext=["crash", "off", "on", "success"];
	    x = obj.position;
	    v = obj.velocity;
        a = obj.acceleration;
        f = obj.force;
	    t = obj.time;
        t0=obj.tStart;
        stat = obj.status;

	    disp("position-x: " + x(1)+" position-y: " + x(2));
        disp("velocity-x: " + v(1)+" velocity-y: " + v(2));
        disp("acceleration-x: " + a(1)+" acceleration-y: " + a(2));
        disp("status: " + statustext(stat+2));
        disp("Force: " + f);
	    disp("time: "+toc(t0));
	    disp("time since last update: "+toc(t));
    end

    
    
    %set methods    
    function obj = set.position(obj,x)
        disp("set position");
	    obj.position = x;           % set current position
    end
    
	function obj = set.velocity(obj,v)
        disp("set velocity");
        obj.velocity = v;           % then, update velocity
    end
    
	function obj = set.acceleration(obj,a)
        disp("set acceleration");
        obj.acceleration = a;		% then, update velocity
    end
    
	function obj = set.force(obj,f)
        disp("set force");
        x0 = obj.position;
	    v0 = obj.velocity;
        a0 = obj.acceleration;
        f0 = obj.force;
        alpha0 = obj.angle;
        t=obj.time;
        T = toc(t);
        stat = obj.status;
        disp("updated values")
        if (stat == 1)
                obj.position = x0 + v0*T ; %+ 0.5*a*T^2
                obj.velocity = v0 + a0*T;		% current velocity based on elapsed time
                obj.acceleration = calcA(f0, alpha0)
        else
                x=x0;
                v = [0,0]; 
                a=0;
        end
        obj.force = f;                  % then, update force
        
    end
    
    function obj = set.angle(obj,alpha)
        disp("set angle");
        x0 = obj.position;
	    v0 = obj.velocity;
        a0 = obj.acceleration;
        f0 = obj.force;
        alpha0 = obj.angle;
        t=obj.time;
	    T = toc(t);
        stat = obj.status;
        disp("updated values")
        if (stat == 1)
                obj.position = x0 + v0*T ; %+ 0.5*a*T^2
                obj.velocity = v0 + a0*T;		% current velocity based on elapsed time
                obj.acceleration = calcA(f0, alpha0)
        else
                x=x0;
                v = [0,0]; 
                a=0;
        end
        obj.angle = alpha;                  % then, update force
        
    end
    
    function obj = set.time(obj,t)
        disp("set time");
        obj.time = t;                  % then, update force
        
    end
    
	function obj = set.status(obj,stat)
        disp("set status");
	    % first update positionx based on the old velocity
        obj.status = stat;
    end
    
    
    %get methods
	function x = get.position(obj)
        disp("get position");
	    x=obj.position;
    end
  
	function v = get.velocity(obj)
        disp("get velocity");
	    v=obj.velocity;
    end
      
	function a = get.acceleration(obj)
        disp("get acceleration");
        a = obj.acceleration;
    end
    
    function f = get.force(obj)
        disp("get force");
        f = obj.force;
    end     
    
    function alpha = get.angle(obj)
        disp("get angle");
        alpha = obj.angle;
    end 
    
    function t = get.time(obj)
        disp("get time");
        t = obj.time;
    end  
    
    function t0 = get.tStart(obj)
        disp("get tStart");
        t0 = obj.tStart;
    end
    
    function stat = get.status(obj) %cr is the status
        disp("get status"); 
        global x
            if(obj.status~=-1 & (x > 600 | x < 0))
                obj.status=-1;	
            end
                stat = obj.status;
    end
    
end
end