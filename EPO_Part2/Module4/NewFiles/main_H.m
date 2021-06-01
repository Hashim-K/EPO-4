clear all;clc;
p = [0 0 468 468 233; 0 470 470 0 0; 50 50 50 50 80];
carpos = [100; 100];
Fs = 40000;
b = binit(-1, 15000, 4000, 2500, "aa55aa55");
y = micdata(b, p, carpos);
refSig = refSignal(b,p);
[Loc, AMatrix, bMatrix, R, yMatrix, hhat] = TDOA_Algorithm(refSig, y, p, Fs);

for i=1:width(p)
    subplot(width(p),1,i)
    plot(hhat(:,i))
%     xlim([0 15000])
end
