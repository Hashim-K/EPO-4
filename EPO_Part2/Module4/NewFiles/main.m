p = [0 0 600 600 300; 0 600 600 0 0; 0 0 0 0 0];
% p = [0 600; 0 0; 0 0];
carpos = [300; 300; 0];
Fs = 40000;
%b = binit(Fs, -1, -1, -1, "");
%[refSig, y] = micdata(b, p, carpos);
% h = decon(refSig, y, 0); %mode 0 = freq domain, mode 1 = match filter
%[h, beta_hat] = rir_generator_x(343, Fs, (p./100)', (carpos./100)', [6 6 6], 0.5); %perfect impulse generator
%if using the above line, carpos must be 3 dimensional.
[location, r] = TDOA(h, p, Fs);
disp("Actual position:")
disp(carpos)
disp("Estimated position:")
disp(location)