%Calvin's Script
%define all 5 microphone inputs and beacon input
%Timer0 = 20kHz, Timer1 = 4kHz, Timer3 = 6Hz.
p = [0 0 600 600 300; 0 600 600 0 0; 0 0 0 0 0];
b = beacon;
N = 5; %Number of mics for testing
Fs = b.Fs; %Sampling frequency
% Timer3 = 6; %Hz for timer3
b.code = 'aa55aa55';
b.Freq0 = 10000;
b. Freq1 = 4000;
b.Count3 = 500;
beaconSig = refsignal_new(b.Freq0, b.Freq1, b.Count3, b.code, Fs);
b.message = beaconSig;
s = micarray(p,b);
temp = receive(s, [1;1]);
referenceSig = temp(:,1);
clear temp;
y = receive(s, [100;300]);
y = [y; zeros(length(referenceSig),5)];
h = zeros(length(y)-length(referenceSig)+1, N);
for i = 1:N
    h(:,i) = deconmf(referenceSig, y(:,i));
end
r = TDOA(h, Fs);
[location, A, B] = localize(r, p);

% for i=1:5
%     subplot(5,1,i)
%     plot(h(:,i))
% end