%distsensors: parking sensors on KITT (both L and R)
% to function, needs a polygon object representing the obstacles
%
% usage:
% P = [0 0; 0 2; 2 2; 2 0];	% vertices
% pgon = polyshape(P)		% define obstacle
% LR = distsensors(pgon)	% create sensor, initialize with obstacle
% plot(LR)			% plot obstacle
% plot(LR,gca,[0;1],[1;0]);	% plot obstacle and sensor cone in current axes
%
% distL(LR,[0;1],[-1;0])	% distance of left sensor to obstacles
% distR(LR,[0;1],[-1;0])	% distance of right sensor to obstacles
% crash(LR,[0;1])		% check if x is located within obstacle
% crashcar(LR,[1;1],[1;1])	% check if any corner of the car is within
%
% Alle-Jan van der Veen, TU Delft, 12 May 2020
