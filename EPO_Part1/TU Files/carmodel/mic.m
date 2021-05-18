% mic: define a microphone object, with a handle (pointer) to it
%
% Usage:
% s = mic(index,[x;y])	% create microphone #number, location [x;y]
% s			% show status
% x = response(s,dist, message) % measured mic signal when message was
%                       % transmitted from distance dist (in cm)
%                       % the length of the response is equal to the length
%                       % of the message (so use zero padding if needed)
%
% ERROR no input validation yet...
%
% Alle-Jan van der Veen, TU Delft, 5 May 2020; 25 May 2020

