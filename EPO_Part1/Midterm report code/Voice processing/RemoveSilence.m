function [t_start,t_end,y_nosilence] = RemoveSilence(y,threshold)
    
    % find() samples that have amplitudes larger than the threshod
    nonsilent_samples = find(abs(y) > threshold);
    t_start=nonsilent_samples(1);
    t_end=nonsilent_samples(end);
    % only keep the signal between the first and last sample
    y_nosilence= y( t_start: t_end);
    
end

