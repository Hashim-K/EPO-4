% Create a beacon object
%
% Usage:
% b = beacon		% create a beacon; b is a handle (pointer) to it
% b = beacon(true,Fs)	% create a beacon, switched on, Tx sample rate Fs
% b.button = true	% switch 'on'
% b			% show status
% b.message		% returns the transmit message based on the parameters
% listen(b)		% play the message on the computer loudspeaker
%
% ERROR: need input parameter checking (some done in "refsignal")
% Alle-Jan van der Veen, TU Delft, 5 May 2020
%

