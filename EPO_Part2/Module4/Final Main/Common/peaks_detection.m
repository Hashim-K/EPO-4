function [R] = peaks_detection(hhat,tolerance,position, Fs, i, j)
    maxDist = sqrt(max(position(1,:))^2 + max(position(2,:))^2);
    searchRange = ceil(maxDist*Fs/34300);
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
end