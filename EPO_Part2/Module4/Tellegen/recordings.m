Port ='\\.\COM10';
result = EPOCommunications('open',Port);
EPOCommunications('transmit','S'); 

EPOCommunications('transmit','A1');
EPOCommunications('transmit','B15000'); % set the bit frequency
EPOCommunications('transmit','F5000');% set the carrier frequency
EPOCommunications('transmit','R2500'); % set the repetition count
EPOCommunications('transmit','C0x50f1072b'); % set the audio cod

x = pa_wavrecord(1, 1,2*8000);

%correct = [ 3, 4 , 1 , 2 ,5];
for i = 1:1
    subplot(1,5,i)
    plot(y(:,i))
    title(i);
end

save close_mic_1 x 
pause (2);
result = EPOCommunications('close'); 