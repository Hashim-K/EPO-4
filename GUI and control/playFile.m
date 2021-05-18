function obj =  playFile(myfile)
   [y,Fs]=audioread(myfile);
   obj = audioplayer(y, Fs);
end