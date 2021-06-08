function location = get_kitt_pos(x, y, p, Fs)
%Convention is that x is reference signal, y are microphone recordings, p is a
%column vector matrix of the microphone [x y z] transposed, positions and Fs is the 
%sampling frequency used in the recording of y
h = decon(x, y, 1); % 1 =  matched filter, 0 = frequency deconvolution
[location, ~] = TDOA(h, p, Fs);
end