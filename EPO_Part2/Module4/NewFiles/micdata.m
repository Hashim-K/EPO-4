function [referenceSignal, micout] = micdata(beacon, micpos, carpos)
    %Microphone virtual recording
    s = micarray(micpos, beacon);
    s.numsamples = length(beacon.message);
    temp = receive(s, [1;1]);% Recording when the car is very close to a
    %microphone
    referenceSignal = temp(:,1);
    micout = receive(s, carpos);
end