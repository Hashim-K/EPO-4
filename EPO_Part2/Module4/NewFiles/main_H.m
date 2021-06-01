clear all;clc;
p = [0 0 468 468 233; 0 470 470 0 0; 50 50 50 50 80];
carpos = [100; 100];
Fs = 40000;
b = binit(-1, -1, -1, 883, "92340f6b");
y = micdata(b, p, carpos);
refSig = refSignal(b,p);
[location, AMatrix, bMatrix, R, yMatrix, hhat] = TDOA_Algorithm(refSig, y, p, Fs);

for i=1:width(p)
    subplot(width(p),1,i)
    plot(hhat(:,i))
%     xlim([0 15000])
end
disp(location-carpos);