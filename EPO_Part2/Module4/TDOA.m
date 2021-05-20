%Calvin's Script
function r = TDOA(h, Fs)
    c = 343;
    tolerance = 0.05;
    maxDist = sqrt(2)*6;
    searRange = ceil(maxDist*Fs/c);
    N = width(h);
    r = zeros(N-1,N);
    for i = 1:N-1
        for j = i+1:N
            pkloc = find(abs(h(:,i)) > tolerance*max(abs(h(:,i))));
            if pkloc(1) < searRange
                pkloc2 = find(abs(h(1:pkloc(1)+searRange,j)) >...
                tolerance*max(abs(h(1:pkloc(1)+searRange,j))));
            else
                pkloc2 = searRange + find(abs(h(pkloc(1)-searRange:...
                pkloc(1)+searRange,j)) > tolerance*max(abs(h(pkloc(1)...
                -searRange:pkloc(1)+searRange,j))));
            end
            r(i,j) = (pkloc(1)-pkloc2(1))*(c/Fs);
        end
    end
end
