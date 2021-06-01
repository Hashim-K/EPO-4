clear;clc;
loc=[200;300];
p = [0 0 600 600 300; 0 600 600 0 0; 0 0 0 0 0];
%pos = [0, 0; 0, 600; 600, 600; 600, 0; 300, 0];
Fs=40000;
bec = beacon(true,Fs);
bec.code = 'aa55aa55';
bec.Freq0 =20000;
bec.Freq1 = 4000;
bec.Count3 = 500;
beaconSig = refsignal_new(bec.Freq0, bec.Freq1, bec.Count3, bec.code, Fs)';
bec.message = beaconSig;
s = micarray(p,bec);
recordings = receive(s, loc)';
recordings = [recordings, zeros(5,length(beaconSig))];
[x, A, b, R, y, hhat] = TDOA_Algorithm(beaconSig,recordings,p',Fs);
loc'-x

for i=1:5
    subplot(5,1,i)
    plot(hhat(i,:))
end