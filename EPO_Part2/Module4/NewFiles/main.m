clear all;
p = [0 0 468 468 ; 0 470 470 0; 0 0 0 0];
% p = [0 600; 0 0; 0 0];
carpos = [400; 255];
Fs = 40000;
b = binit(Fs, -1, -1, -1, "");
load('measure100_400.mat');
% [refSig, y] = micdata(b, p, carpos);
refSig = y(:,5);
y(:,5) = [];
% h = decon(refSig, y, 0); %mode 0 = freq domain, mode 1 = match filter
%[h, beta_hat] = rir_generator_x(343, Fs, (p./100)', (carpos./100)', [6 6 6], 0.5); %perfect impulse generator
%if using the above line, carpos must be 3 dimensional.
% [location, r] = TDOA(h, p, Fs);
