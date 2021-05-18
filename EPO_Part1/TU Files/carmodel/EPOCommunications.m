%EPOCommunications: the standard interface for communicating with KITT
% Refer to the manual for details. Usage is detailed in Section 2.2.2.
% On top of that, this function also implements:
% new 'init' commands for
%   - initializing location/orientation 
%   - initializing micarray sample rate, received samples
%   - initializing obstacles (including arena boundary)
% new method 'receive' to collect received samples from micarray
% augmented 'open' command to ask for 'public' (access to position/direction)
%
%
% Alle-Jan van der Veen, TU Delft, 6 May 2020
%     13 May 2020: support for obstacles
%
