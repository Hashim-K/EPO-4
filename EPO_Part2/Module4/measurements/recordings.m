Port ='\\.\COM8';
result = EPOCommunications('open',Port);
EPOCommunications('transmit','S'); 

EPOCommunications('transmit','A1');
EPOCommunications('transmit','B10000'); % set the bit frequency
EPOCommunications('transmit','F4000');% set the carrier frequency
EPOCommunications('transmit','R2500'); % set the repetition count
EPOCommunications('transmit','C0xaa55aa55'); % set the audio cod

y = pa_wavrecord(1, 5,10*8000);

for i = 1:5
    subplot(1,5,i)
    plot(y(:,i))
end

save measure400_400 y 
pause (2);
result = EPOCommunications('close'); 