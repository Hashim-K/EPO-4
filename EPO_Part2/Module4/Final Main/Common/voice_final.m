%function out = voice_final(model, mu_train, sigma_train)
clc;
    Fs = 8000;
    win = 20e-3;
    threshold = 0.1;
    L = Fs*win;
    ov = 0.5*L;
    disp("Starting recording.");
%     x = pa_wavrecord(6, 6, Fs);
    recorder = audiorecorder(44100,16,1,5);
    recordblocking(recorder, 2);
    disp("Ending recording.");
    x = getaudiodata(recorder);
    
    if(max(abs(x))<0.05)
        out = 6;
    else
        feat = ExtractFeat(x, Fs, L, ov, threshold);
        feat_norm = (feat-mu_train)./sigma_train;
        
    [out, scores] = model.predict(feat_norm);
    out = str2double(out) - 1
    scores
    end

%end