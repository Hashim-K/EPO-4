Port ='\\.\COM15';
result = EPOCommunications('close',Port);
result = EPOCommunications('open',Port);
EPOCommunications('transmit','S'); 

EPOCommunications('transmit','A1');
EPOCommunications('transmit','B15000'); % set the bit frequency
EPOCommunications('transmit','F5000');% set the carrier frequency
EPOCommunications('transmit','R2500'); % set the repetition count
EPOCommunications('transmit','C0x50f1072b'); % set the audio cod


y = pa_wavrecord(1, 5,2*8000);

save('close_mic_rover_2','y');

