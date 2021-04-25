function f0 = FindPitch(y,Fs,L,ov)
    f0 = pitch(y, Fs, 'Method', 'CEP', 'WindowLength', L, 'OverlapLength', ov);
end