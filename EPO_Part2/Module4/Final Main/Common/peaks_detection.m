function [R] = peaks_detection(hhat,tolerance,position, Fs, i, j, mode)
        maxDist = sqrt(max(position(1,:))^2 + max(position(2,:))^2);
        searchRange = ceil(maxDist*Fs/34300);
    if mode == 1
        pkloc = abs(hhat(:,i)) > tolerance*max(abs(hhat(:,i)));
        compVec1 = pkloc.*hhat(:,i);
        [~, pks1] = findpeaks(abs(compVec1));
        if pks1(1) <= searchRange
            pkloc2 = abs(hhat(1:pks1(1)+searchRange,j)) >...
            tolerance*max(abs(hhat(1:pks1(1)+searchRange,j)));

            compVec2 = pkloc2.*hhat(1:pks1(1)+searchRange,j);
            [~, pks2] = findpeaks(abs(compVec2));
        else
            pkloc2 = abs(hhat(pks1(1)-searchRange:...
            pks1(1)+searchRange,j)) > tolerance*max(abs(hhat(pks1(1)...
            -searchRange:pks1(1)+searchRange,j)));

            compVec2 = pkloc2.*hhat(pks1(1)-searchRange:pks1(1)+searchRange,j);
            [~, pks2] = findpeaks(abs(compVec2));
            pks2 = pks2 + pks1(1)-searchRange;
        end
        R=calcD(pks1(1),pks2(1),Fs); 
    else
        N = size(h,2);
        r = zeros(N-1,N);
        for i = 1:N-1
            for j = i+1:N
                pkloc = find(abs(h(:,i)) > tolerance*max(abs(h(:,i))));
                if pkloc(1) <= searRange
                    pkloc2 = find(abs(h(1:pkloc(1)+searRange,j)) >...
                    tolerance*max(abs(h(1:pkloc(1)+searRange,j))));
                else
                    pkloc2 = pkloc(1) - searRange + find(abs(h(pkloc(1)-searRange:...
                    pkloc(1)+searRange,j)) > tolerance*max(abs(h(pkloc(1)...
                    -searRange:pkloc(1)+searRange,j))));
                end
                R=calcD(pkloc(1),pkloc2(1),Fs);
            end
        end
    end
end