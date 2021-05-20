clear;clc;
p = [0 0 600 600 300; 0 600 600 0 0; 0 0 0 0 0];
%pos = [0, 0; 0, 600; 600, 600; 600, 0; 300, 0];
b = beacon;
Fs = b.Fs; %Sampling frequency
% Timer3 = 6; %Hz for timer3
b.code = 'aa55aa55';
beaconSig = refsignal_new(b.Freq0, b.Freq1, b.Count3, b.code, Fs)';
b.message = beaconSig;
s = micarray(p,b);
recordings = receive(s, [200;300])';
x = TDOA_Algorithm(recordings,beaconSig,p',Fs)