%Authors: Hashim Karim & Peter Nagy
%Date: April 2021
%Description: Labday 4, Third Channel Estimate Algorithm

function [h_adjL,Hhat,G,g]=ch3(x,y,L,eps)
    %define Ny an Nx as length of y and x respectively
    Ny = length(y);
    Nx = length(x);
    
    %if L = -1, set it to ideal channel estimate length 
    if L==-1    
        L = Ny - Nx + 1;
    end
    
    %Y and X are the frequency domain of y and x respectively
    Y = fft(y);
    X = fft(x,Ny);
    
    %set G(k) to 1 if |x|>eps, else set it to 0
    G=ones(1,length(X));
    for k=1:length(X)
        if (abs(X(k)) < eps)
            G(k)=0;
        end
    end
    
    %H is the deconvolution of Y and X
    H = Y ./ X;
    
    %Adjust the channel estimate using the Selector (G)
    Hhat=H.*G;
    
    %h_est is the real part of the ifft of Hhat
    h_est = real(ifft(Hhat));
    
    %truncate h_est to length L
    h_adjL = h_est([1:L]);
        
    g = ifftshift(real((ifft(G))));
    G = fftshift(G);
    Hhat = fftshift(Hhat);
end