%Calvin's Script
function r = TDOA(h, Fs)
    c = 343;
    N = width(h);
    [~, pks] = max(abs(h));
    disp(pks)
    r = zeros(N-1,N);
    for i = 1:N-1
        for j = i+1:N
            r(i,j) = (pks(i)-pks(j))*(c/Fs);
        end
    end
end