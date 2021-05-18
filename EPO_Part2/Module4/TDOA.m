%Calvin's Script
function r = TDOA(h, Fs)
    c = 343;
    pks = zeros(1,5);
    for i = 1:5
       [~, pks(i)] = max(abs(h(:,i)));
    end
    r = zeros(5,5);
    for i = 1:4
        for j = i+1:5
            r(i,j) = (pks(i)-pks(j))*(c/Fs);
        end
    end
end