% Example script:
%
% Create a class named onoff, placed in file 'onoff.m' (same name as class)
% This demonstrates a simple switch
%
% Usage:
% s = onoff		% create an object containing a single  switch
% s = onoff(true)	% create a switch, initially 'on'
% s.button = true	% switch 'on'
% s.button = false	% switch 'off'
% s			% show status



classdef onoff
    properties
	button logical = false;	% implement a switch; initial value is off
    end

    methods
	function obj = onoff(a)
	    % constructor (same name as class); returns initialized object
	    if nargin == 0
	        a = false;
	    end	
	    obj.button = a;
	end

	function disp(obj)
	    % disp is called when we ask to print the object's values
	    a = obj.button;
	    if a
	       aa = 'on';
	    else
	       aa = 'off';
	    end
	    s = sprintf('button: %s',aa);
	    disp(s);
	end
    end
end
