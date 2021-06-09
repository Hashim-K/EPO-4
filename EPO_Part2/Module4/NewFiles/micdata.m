function micout = micdata(beacon, micpos, carpos)

    %Car initialization
    EPOCommunications('init', ['X' mat2str(carpos)]);
    EPOCommunications('init', 'D[0;1]');
    %Mic's initialization
    EPOCommunications('init',['P' mat2str(micpos)]);
    EPOCommunications('init', ['J' int2str(beacon.Fs)]);%Mic sample freq
    EPOCommunications('init','N80000'); %Number of samples
    
    kitt = EPOCommunications('open', 'P');
%     kitt = EPOCommunications('open');
    
    %Changing the beacon settings of the kitt
    EPOCommunications('transmit',['B' int2str(beacon.Freq1)]); % set the bit frequency
    EPOCommunications('transmit',['F' int2str(beacon.Freq0)]);% set the carrier frequency
    EPOCommunications('transmit',['R' int2str(beacon.Count3)]); % set the repetition count
    EPOCommunications('transmit',['C0x' beacon.code]); % set the audio code
    
    %Turning on the beacon
    EPOCommunications('transmit', 'A1');
 
    micout = EPOCommunications('receive');
    kitt = EPOCommunications('close');
end