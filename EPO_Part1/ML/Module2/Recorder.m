Fs = 8000;
n=n+1;
recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')
recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');
plot(getaudiodata(recObj));
dir=lower(input("What direction?: [Ini/Go/Halt/On/Start/Stop/Boot/Power]", 's'))
if dir=="ini"
    Ini(:,n) = getaudiodata(recObj);
end
if dir=="go"
    Go(:,n) = getaudiodata(recObj);
end
if dir=="halt"
    Halt(:,n) = getaudiodata(recObj);
end
if dir=="on"
    On(:,n) = getaudiodata(recObj);
end
if dir=="start"
    Start(:,n) = getaudiodata(recObj);
end
if dir=="stop"
    Stop(:,n) = getaudiodata(recObj);
end
if dir=="boot"
    Boot(:,n) = getaudiodata(recObj);
end
if dir=="power"
    Power(:,n) = getaudiodata(recObj);
end