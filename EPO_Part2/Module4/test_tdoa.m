%Calvin's Script
%define all 5 microphone inputs and beacon input
y1 = ;
y2 = ;
y3 = ;
y4 = ;
y5 = ;
beaconSig = ;
Fs = 40000; %Sampling frequency
h = zeros(5,length(y1)-length(beaconSig)+1);
y = [y1 y2 y3 y4 y5];
for i = 1:5
    h = deconmf(y(:,i), beaconSig);
end
r = TDOA(h, Fs);
location = localize(r, p);