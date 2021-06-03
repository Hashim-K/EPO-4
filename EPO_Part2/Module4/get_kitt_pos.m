function location = get_kitt_pos(x, y, p, Fs)

h = decon(x, y, 1); % 1 =  matched filter, 0 = frequency deconvolution

[location, ~] = TDOA(h, p, Fs);

end