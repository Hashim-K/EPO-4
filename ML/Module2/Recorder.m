Fs = 8000;

recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')
recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');
Right(:,10) = getaudiodata(recObj);
