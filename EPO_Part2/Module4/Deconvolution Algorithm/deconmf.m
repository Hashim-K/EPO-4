%Matched filter deconvolution
function hhat = deconmf(x, y)

    Nx = length(x);
    x = x(:); y = y(:);    % ensure column vectors
    xr = flipud(x);        % reverse the sequence x (assuming a col vector)
    h = filter(xr,1,y);    % matched filtering
    h = h(Nx:end);       % skip the first Nx samples, so length(h) = L
    alpha = x'*x;          % estimate scale
    hhat = h./alpha;           % scale down

end