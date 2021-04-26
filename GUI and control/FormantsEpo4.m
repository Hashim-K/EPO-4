function [t_vec,frmtns] = FormantsEpo4(y,Fs,L,ov)

% Complete this function for the estimation of formants
%
% INPUTS
%           y  - Audio signal
%           Fs - Sampling frequency
%           L  - Length of the window (in samples)
%           ov - Length of the overlap (in samples)
%
% OUTPUTS
%           t_vec  - Time vector for the window-based analysis
%           frmtns - Formants for each window of length L
%
% -------------------------------------------------------------------------
%% Formant estimation in a moving window approach 

N = length(y);         % length of the audio signal
win = hann(L);         % window
t_vec = (L:ov:N)/Fs;  % time vector for plotting
preemph = [1 0.63];    % Coefficients of the pre-emphasis filter (Highpass)
count = 0; 
lng = floor((N-L)/(ov))+1; % Number of windows within the signal
frmtns = NaN(lng,3,'double');
f0 = NaN(lng,1,'double');

for iter = 1:ov:(N - L) % Formant estimation for each window of length L
    count = count+1;
    tmp = y(iter:iter+L-1,:);
    y1 = tmp.*win;
    y1 = filter(1,preemph,y1);
    A = lpc(y1,8);          % Linear predictor coefficients
    rts = roots(A);
    rts = rts(imag(rts)>=0);
    angz = atan2(imag(rts),real(rts));
    [frqs,indices] = sort(angz.*(Fs/(2*pi)));
    bw = -1/2*(Fs/(2*pi))*log(abs(rts(indices)));
    nn=1; frs = NaN(1,3,'double');
    for kk = 1:length(frqs)
        if (frqs(kk) > 90 && bw(kk) <400)
            frs(nn) = frqs(kk);
            nn = nn+1;
        end
    end
    frmtns(count,:) = frs(1:3);
end



