clear all;
p = [0 0 468 468 233; 0 470 470 0 0; 50 50 50 50 80];
carpos = [1; 10];
Fs = 44100;
b = binit(44100, 10000, -1, 1250, "50f1072b");
%f2d41e3c
raw_data = micdata(b, p, carpos);
y = zeros(length(raw_data), width(raw_data));
for i = 1:width(raw_data)
   y(:,i) = lowpass(raw_data(:,i),10000, Fs); 
end
raw_ref = refSignal(b,p);
refSig = lowpass(raw_ref, 10000, Fs);
h = decon(refSig, y, 1); %mode 0 = freq domain, mode 1 = match filter
% [h, beta_hat] = rir_generator_x(343, Fs, (p./100)', (carpos./100)', [6 6 6], 0.5); %perfect impulse generator
%if using the above line, carpos must be 3 dimensional.
location = TDOA(h, p, Fs);

disp(location-carpos);
% for i=1:width(p)
%     subplot(width(p),1,i)
%     plot(h(:,i))
% end
