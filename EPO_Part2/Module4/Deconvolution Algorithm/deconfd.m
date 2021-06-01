%Frequency domain deconvolution
function h = deconfd(x, y, eps)

    Ny = length(y); 
    Nx = length(x); 
    L = Ny - Nx + 1;

    Y = fft(y);
    X = fft([x; zeros(Ny - Nx,1)]);  % zero padding to length Ny
    H = Y ./ X;                          % frequency domain deconvolution

    ii = find(abs(X) > eps);
    G = zeros(1,length(X));
    for i = 1:length(ii)
        G(ii(i)) = 1;
    end

    H = H.*G;
    h = ifft(H);

    h = real(h(1:L));
    
end