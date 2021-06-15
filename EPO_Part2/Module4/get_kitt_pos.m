function location = get_kitt_pos(raw_data_x, raw_data_y, p, Fs)
%Convention is that x is reference signal, y are microphone recordings, p is a
%column vector matrix of the microphone [x y z] transposed, positions and Fs is the 
%sampling frequency used in the recording of y
y = zeros(length(raw_data_y), width(raw_data_y));
for i = 1:width(raw_data)
   y(:,i) = lowpass(raw_data_y(:,i),10000, Fs); 
end
x = lowpass(raw_data_x,10000, Fs);
h = decon(x, y, 1); % 1 =  matched filter, 0 = frequency deconvolution
location = TDOA(h, p, Fs);
end