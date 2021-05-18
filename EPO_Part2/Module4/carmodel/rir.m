%rir
% Compute the room impulse response for mic and loudspeaker locations (in cm)
% at sample rate Fs. Requires compiled rir_generator_x (or
% rir_generator_x_threaded).
% Inputs:
%   micpos: position of mic in cm; vector 3 x 1 ; e.g. [0;0;30];
%   loudpos: position of beacon in cm; vector 2 x 1 ; e.g. [100; 100];
%   fs: sampling frequency.
% Outputs: 
%   h: calculated room impulse response.
% Usage: h = rir(micpos,loudpos,fs);
