function micout = micdata(beacon, micpos, carpos)

    %Car initialization
    EPOCommunications('init', ['X' mat2str(carpos)]);
    EPOCommunications('init', 'D[0;1]');
    %Mic's initialization
    EPOCommunications('init',['P' mat2str(micpos)]);
    EPOCommunications('init', ['J' int2str(beacon.Fs)]);%Mic sample freq
    EPOCommunications('init','N5000'); %Number of samples
    
    kitt = EPOCommunications('open', 'P');
    
    %Changing the beacon settings of the kitt
    EPOCommunications('transmit',['B' mat2str(beacon.Freq1)]); % set the bit frequency
    EPOCommunications('transmit',['F' mat2str(beacon.Freq0)]);% set the carrier frequency
    EPOCommunications('transmit',['R' mat2str(beacon.Count3)]); % set the repetition count
    EPOCommunications('transmit',['C0x' beacon.code]); % set the audio code
    
    %Turning on the beacon
    EPOCommunications('transmit', 'A1');
 
    micout = EPOCommunications('receive');
end