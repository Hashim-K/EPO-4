function x_vec = ExtractFeat(y,Fs,L,ov,threshold)
    
    % normalize y
    % remove mean
    y_norm=y-mean(y);  
    % devide by the max abs value
    y_norm=y_norm/max(abs(y));
    
    % remove silence
    [~,~,y_nosilence] = RemoveSilence(y_norm, threshold);
    
    aFE = audioFeatureExtractor("SampleRate", Fs, "Window", hamming(round(0.025*Fs), "periodic"),...
     "OverlapLength", round(0.0125*Fs), "linearSpectrum", true, "melSpectrum", true, ... 
     "barkSpectrum", true, "erbSpectrum", true, "mfcc", true, "mfccDelta", true, ...
     "mfccDeltaDelta", true, "gtcc", true, "gtccDelta", true,...
     "gtccDeltaDelta", true, "spectralCentroid", true, "spectralCrest", true, ...
     "spectralDecrease", true, "spectralEntropy", true, "spectralFlatness", true, ...
     "spectralFlux", true, "spectralKurtosis", true, "spectralRolloffPoint", true, ...
     "spectralSkewness", true, "spectralSlope", true, "spectralSpread", true, ...
     "pitch", true, "harmonicRatio", true);

%     aFE = audioFeatureExtractor("SampleRate", Fs, ...
%      "linearSpectrum", true, "melSpectrum", true, ... 
%      "barkSpectrum", true, "erbSpectrum", true, "mfcc", true, "mfccDelta", true, ...
%      "mfccDeltaDelta", true, "gtcc", true, "gtccDelta", true,...
%      "gtccDeltaDelta", true, "spectralCentroid", true, "spectralCrest", true, ...
%      "spectralDecrease", true, "spectralEntropy", true, "spectralFlatness", true, ...
%      "spectralFlux", true, "spectralKurtosis", true, "spectralRolloffPoint", true, ...
%      "spectralSkewness", true, "spectralSlope", true, "spectralSpread", true, ...
%      "pitch", true, "harmonicRatio", true);

 
    features = (extract(aFE, y_nosilence));

    % find pitch
    f0 = FindPitch(y_nosilence,Fs,L,ov);
    
    % find formants
    [~,frmtns] = FormantsEpo4(y_nosilence,Fs,L,ov);
    
    % features
    % mean, median, and variance of the pitch: 
    % you can use nanmean(), nanmedian(), nanvar()
    x1=nanmean(f0);
    x2=nanmedian(f0);
    x3=nanvar(f0);

    % mean, median, and variance of each formants
    % if you set dim=1, you can find it for all three formants together
    x4=nanmean(frmtns, 1);
    x5=nanmedian(frmtns, 1);
    x6=nanvar(frmtns, 1);

    % mean, median, and variance of each formants
    f1f2=frmtns(:,1)./frmtns(:,2); % F1/F2
    x7=nanmean(f1f2);
    x8=nanmedian(f1f2);
    x9=nanvar(f1f2);
    F = fft(y); 
    x10 = sum(F.*conj(F));
    x11 = nanmean(features);
    x12 = nanmedian(features);
    x13 = nanvar(features);

    % putting all the features together: size 1*16
%     x_vec=[x1, x4(:,2), x9, x10, x11, x12, x13];
%     x_vec=[x1, x2, x3, x4, x5, x6, x7, x8, x9, x10];
%     x_vec=[x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13];
    x_vec=[x11(214) x11(226) x12(108) x12(118) x12(256) x12(279) x13(43)...
            x13(203) x13(241) x13(267) x13(283)];
    
end