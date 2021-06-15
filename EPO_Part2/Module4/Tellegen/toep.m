function X = toep(x0,Ny,L);
% Create a Toeplitz matrix X, size Ny * L, first column given by x0.
% Suppose x0 has Nx entries, then
% if L is not specified, take L = Ny - Nx + 1
%
% Usage: The convolution of x0 and y is given by X*y
%        The matched filter of x0 and y is given by X'*y
% (Both can be more efficiently computed using 'filter'.)

Nx = length(x0);
x0 = x0(:);		% ensure x0 is a column vector

if Nx > Ny, 
    error('Length of x0 should be at most equal to Ny');
end

if nargin < 3,
    % L not specified
    L = Ny - Nx + 1;	% will have L >= 1
end

% zero pad x0 to length Ny
x0 = [x0; zeros(Ny-Nx,1)];

% create Toeplitz matrix Ny * L, first column x0
X = toeplitz(x0,[x0(1) zeros(1,L-1)]);

