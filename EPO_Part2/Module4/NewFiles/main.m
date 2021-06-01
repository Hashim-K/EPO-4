clear all;
p = [0 0 468 468 233; 0 470 470 0 0; 50 50 50 50 80];
% p = [0 600; 0 0; 0 0];
carpos = [100; 300];
Fs = 40000;
b = binit(-1, -1, -1, 1500, "93240f6b");
y = micdata(b, p, carpos);
refSig = refSignal(b,p);
% load measure100_400.mat;
h = decon(refSig, y, 1); %mode 0 = freq domain, mode 1 = match filter
% [h, beta_hat] = rir_generator_x(343, Fs, (p./100)', (carpos./100)', [6 6 6], 0.5); %perfect impulse generator
%if using the above line, carpos must be 3 dimensional.
[location, r] = TDOA(h, p, Fs);

disp(location-carpos);
% for i=1:width(p)
%     subplot(width(p),1,i)
%     plot(y(:,i))
% %     xlim([0 15000])
% end
