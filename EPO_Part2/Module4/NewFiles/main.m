clear all;
p = [0 0 468 468 234; 0 470 470 0 0; 0 0 0 0 0];
% p = [0 600; 0 0; 0 0];
carpos = [246; 5];
b = binit(-1, -1, -1, -1, "");
y = micdata(b, p, carpos);
refSig = micdata(b, p, [1; 1]);
refSig(:,2:width(p)) = [];
h = decon(refSig, y, 0); %mode 0 = freq domain, mode 1 = match filter
% [h, beta_hat] = rir_generator_x(343, Fs, (p./100)', (carpos./100)', [6 6 6], 0.5); %perfect impulse generator
%if using the above line, carpos must be 3 dimensional.
% [location, r] = TDOA(h, p, Fs);

for i=1:width(p)
    subplot(width(p),1,i)
    plot(h(:,i))
end
