% classdef for car_accel, placed in file 'car_accel.m' (use same name as class)
%
% Implements dynamic properties of Kitt: 2D position, with acceleration,
% friction, steering (driving on circles with a radius that depends on
% steering angle)
% (combines car_steer with car_linear)
%
% Usage:
% kitt = car_accel	% create a new car
% kitt.force = 3	% apply acceleration force (< 10 N = F_max)
% kitt.angle = .12	% give it some steering angle (of the wheels, radians)
% kitt			% update position based on accel before displaying
% kitt.position		% calculated [x;y] position, in cm
% kitt.orientation	% calculated driving direction (pointing vector)
% kitt.velocity		% calculated velocity (scalar), in cm/s
%
% Alle-Jan van der Veen, TU Delft, 1 May 2020
%
