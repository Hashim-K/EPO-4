clear all;
virtual=1;

%Beacon Properties
B=Beacon(44100,15000,5000,2500,"50f1072b")
Portnumber=15
%add folder paths
addpath("Common");
if virtual == 1
    addpath("Virtual");
    Port =convertStringsToChars("\\.\COM"+portnumber);
    result = EPOCommunications('close');
    result = EPOCommunications('open',Port);
    EPOCommunications('transmit','S'); 
    EPOCommunications('transmit',convertStringsToChars("B"+B.Fb)); % set the bit frequency
    EPOCommunications('transmit',convertStringsToChars"F"+B.Fc));% set the carrier frequency
    EPOCommunications('transmit',convertStringsToChars("R"+B.Rc)); % set the repetition count
    EPOCommunications('transmit',convertStringsToChars("C"+B.C)); % set the audio cod
else
    addpath("Real");
end


%mic positions
micpos = [0 0 468 468 233; 0 470 470 0 0; 24 24 24 24 54];



destinationReached=0;

while (destinationReached~=1)
    get_pos(B)
end