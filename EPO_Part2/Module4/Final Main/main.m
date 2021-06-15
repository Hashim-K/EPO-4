clear all;
virtual=1;
%add folder paths
addpath("Common");
if virtual == 1
    addpath("Virtual");
else
    addpath("Real");
end


%mic positions
micpos = [0 0 468 468 233; 0 470 470 0 0; 24 24 24 24 54];

%Beacon Properties
B=Beacon(44100,15000,5000,2500,"50f1072b")



destinationReached=0;

while (destinationReached~=1)
    get_pos(B)
end