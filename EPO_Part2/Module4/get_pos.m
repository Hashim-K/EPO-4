function pos = get_pos(x,p)
    %EPOCommunications('transmit','S'); %Make sure the beacon is on.
    tic
    y = pa_wavrecord(1, 5,2*8000);
    toc 
    %figure(2)
    %for i = 1:5
    %subplot(1,5,i)
    %plot(y(:,i))
    %title(i);
    %end
  %  toc
    pos = get_kitt_pos(x,y,p,44100);
end 