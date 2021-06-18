function out = voice_final(model, mu_train, sigma_train)

    Fs = 44100;
    win = 20e-3;
    threshold = 0.1;
    L = Fs*win;
    ov = 0.5*L;

    x = pa_wavrecord(6, 6, Fs);
    
    if(max(abs(x))<0.05)
        out = 6;
    else
        feat = ExtractFeat(x, Fs, L, ov, threshold);
        feat_norm = (feat-mu_train)./sigma_train;
        out = str2double(model.predict(feat_norm)) - 1;
    end

end