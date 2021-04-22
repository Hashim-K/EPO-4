classdef car 
    properties
	% status parameters
	positionx		% reference positionx at time t0
    positiony
	velocity = 0;		% init value is needed!
    acceleration = 0;
	time
    status; % -1 = crash, 0 = off, 1 = on
    end

    methods
	function obj = car(x,v,a)
	    % constructor (same name as class); returns initialized object
	    if nargin == 0
	        x = 0; v = 0;	a = 0;% if no input arguments
	    end	
	    obj.positionx = x;   % (calls set.positionx; also starts timer)
	    obj.velocity = v;	% calls set.velocity (thus, init value needed)
        obj.acceleration = a;
        obj.status=0;
        
	end

	function disp(obj)
	    % disp prints the object's values
	    % first update positionx based on current time and velocity
        global x
	    x = obj.positionx;	% calls get.positionx, calculates based on current velocity and time
        %y = obj.positiony;
	    v = obj.velocity;
        a = obj.acceleration;
	    t = obj.time;
        stat = obj.status;

	    s = sprintf('positionx: %g',x);
	    disp(s);
	    s = sprintf('velocity: %g',v);
	    disp(s);
	    s = sprintf('acceleration: %g',a);
	    disp(s);
	    s = sprintf('status: %g',stat);
	    disp(s);
	    s = sprintf('time since last update: %g',toc(t));
	    disp(s);
	end

	function obj = set.velocity(obj,v)
	    % first update positionx based on the old velocity
            x1 = obj.positionx;		% calls get.positionx, gives x1, not x0

            obj.positionx = x1;		% calls set.positionx; resets timer

             obj.velocity = v;		% then, update velocity

    end
    
	function obj = set.acceleration(obj,a)
	    % first update positionx based on the old velocity
            v1 = obj.velocity;		% calls get.positionx, gives x1, not x0

            obj.velocity = v1;		% calls set.positionx; resets timer
	    obj.acceleration = a;		% then, update velocity
    end
    
	function obj = set.status(obj,stat)
	    % first update positionx based on the old velocity
        obj.status = stat
    end
    
    function obj = set.positionx(obj,x)
	    % when 'positionx' is set, also reset time; leave v the same
	    obj.positionx = x;		% set current positionx

            obj.time = tic;             % store current time
    end
    
	function x1 = get.positionx(obj)
	    % when 'positionx' is queried, calculate current positionx
	    % (note, cannot update it because 'obj' is not an output param)
            t0 = obj.time;		% t0 = time when last called
            x0 = obj.positionx;		% x0 = positionx at time t0
            v = obj.velocity;		% v = velocity at time t0
            %global status_x_pos
            T = toc(t0);		% elapsed time (in seconds) since t0
            %if (obj.status == 1)
            %    x1 = status_x_pos;
            %else
                x1 = x0 + v*T;		% current positionx based on elapsed time
            %end
    end
    
    function stat = get.status(obj) %cr is the status
        global x
            if(x > 600 | x < 0)
                obj.status=-1;	
            end
                stat = obj.status;
    end
    
	function v1 = get.velocity(obj)
	    % when 'positionx' is queried, calculate current positionx
	    % (note, cannot update it because 'obj' is not an output param)
            t1 = obj.time;		% t1 = time when last called
            v0 = obj.velocity;		% v0 = velocity at time t0
            a = obj.acceleration;		% v = accel at time t0

            T = toc(t1);		% elapsed time (in seconds) since t0

            if (obj.status == -1)
                v1 = 0;
            else
                v1 = v0 + a*T;		% current velocity based on elapsed time
            end
    end
    
    
end
end