%micarray: incorporate mic objects into an array 
%
% Usage:
% b = beacon;		% create a beacon object (b is pointer to it) 
% s = micarray(X,b);	% create micarray object with mic positions in X and
% 			% (optional) beacon object b (use message and Fs)
% x = receive(s,loc)	% receive signals from mics for message transmitted
%			% from loc
% listen(s,loc)		% soundcheck: listen to message received at mic #1, 
%                       % transmitted from loc (optional)
%
% Alle-Jan van der Veen, TU Delft, 5 May 2020
%
