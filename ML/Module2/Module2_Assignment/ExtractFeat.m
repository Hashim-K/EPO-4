function x_vec=ExtractFeat(y,Fs,L,ov,threshold)
    
    % normalize y
    % remove mean
    y_norm=y-mean(y);  
    % devide by the max abs value
    y_norm=y_norm/max(abs(y));
    
    % remove silence
    [~,~,y_nosilence] = RemoveSilence(y_norm, threshold);

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

    % putting all the features together: size 1*15
    x_vec=[x1,x2,x3,x4,x5,x6,x7,x8,x9];
    
end