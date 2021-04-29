if exist('Ini','var')==0
    n=0;
    m=1;
end
limit=20; %Number of recordings wanted
if n==limit
    m=m+1; %select what word gets recorded
end
Fs = 8000;
n=n+1; %select which recording is getting recorded



array=["ini","go","halt","on","start","stop","boot","power"];
recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp("Say " + array(m))
recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');
plot(getaudiodata(recObj));
if array(m)=="ini"
    Ini(:,n) = getaudiodata(recObj);
end
if array(m)=="go"
    Go(:,n) = getaudiodata(recObj);
end
if array(m)=="halt"
    Halt(:,n) = getaudiodata(recObj);
end
if array(m)=="on"
    On(:,n) = getaudiodata(recObj);
end
if array(m)=="start"
    Start(:,n) = getaudiodata(recObj);
end
if array(m)=="stop"
    Stop(:,n) = getaudiodata(recObj);
end
if array(m)=="boot"
    Boot(:,n) = getaudiodata(recObj);
end
if array(m)=="power"
    Power(:,n) = getaudiodata(recObj);
end