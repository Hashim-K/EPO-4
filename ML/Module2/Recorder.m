Fs = 8000;

recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')
recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');
dir=lower(input("What direction?: [Left/Right/Up/Down]", 's'))
if dir=="left"
    Left(:,10) = getaudiodata(recObj);
if dir=="right"
    Right(:,10) = getaudiodata(recObj);
if dir=="up"
    Up(:,10) = getaudiodata(recObj);
if dir=="down"
    Down(:,10) = getaudiodata(recObj);