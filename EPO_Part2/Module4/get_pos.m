function pos = get_pos(x,p)

%     B=Beacon(44100,15000,5000,2500,"50f1072b")
%     portnumber=15
%     Port =convertStringsToChars("\\.\COM"+portnumber);
%     result = EPOCommunications('close');
%     result = EPOCommunications('open',Port);
%     EPOCommunications('transmit','S'); 
%     EPOCommunications('transmit',convertStringsToChars("B"+B.Fb)); % set the bit frequency
%     EPOCommunications('transmit',convertStringsToChars("F"+B.Fc));% set the carrier frequency
%     EPOCommunications('transmit',convertStringsToChars("R"+B.Rc)); % set the repetition count
%     EPOCommunications('transmit',convertStringsToChars("C"+B.C)); % set the audio cod



    EPOCommunications('transmit','S'); %Make sure the beacon is on.
    EPOCommunications('transmit','A1');
    pause(0.1);
    tic
    y = pa_wavrecord(1, 5,44100);
    toc

    [pos,h] = get_kitt_pos(x,y,p,44100);
    EPOCommunications('transmit','A0');
    disp("beacon off")
%     figure('name','Y recordings')
%     for i = 1:5
%         subplot(5,1,i)
%         plot(y(:,i))
%         title(i);
%     end
%     figure('name','Channel Estimates')
%     for i = 1:5
%         subplot(5,1,i)
%         plot(h(:,i))
%         title(i);
%     end
    pause(2);
end 