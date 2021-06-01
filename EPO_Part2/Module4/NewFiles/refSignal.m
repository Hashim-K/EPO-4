function y = refSignal(b, p)
    
    y = micdata(b, p, [0; 1]);
    y(:,2:width(p)) = [];
    refRange = (b.Fs*(b.Count3/b.Freq1));
    y(refRange:end) = [];

end