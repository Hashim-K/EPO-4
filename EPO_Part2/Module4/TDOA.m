%Calvin's Script
%This top version finds all values greater than a tolerance * the max value
%and then takes the first value found as the peak.
function [location,r] = TDOA(h, p, Fs)
    c = 343;
    tolerance = 0.85;
    maxDist = sqrt(4.7^2 + 4.68^2);
    searRange = ceil(maxDist*Fs/c);
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
            r(i,j) = 100*(pkloc(1)-pkloc2(1))*(c/Fs);%Conversion from m 
            %to cm takes place
        end
    end
    location = localize(r, p);
end

%-------------------------------------------------------------------------%

%This second version looks for all values greater than the tolerance * max 
%value and sets any value that isn't greater than the tolerance * the max 
%value to zero then the peaks are found and the first one is taken.
% function location = TDOA(h, p, Fs)
%     c = 343;
%     tolerance = 0.8;
%     maxDist = sqrt(4.7^2 + 4.68^2);
%     searRange = ceil(maxDist*Fs/c);
%     N = width(h);
%     r = zeros(N-1,N);
%     for i = 1:N-1
%         for j = i+1:N
%             pkloc = abs(h(:,i)) > tolerance*max(abs(h(:,i)));
%             compVec1 = pkloc.*h(:,i);
%             [~, pks1] = findpeaks(abs(compVec1));
%             if pks1(1) <= searRange
%                 pkloc2 = abs(h(1:pks1(1)+searRange,j)) >...
%                 tolerance*max(abs(h(1:pks1(1)+searRange,j)));
%             
%                 compVec2 = pkloc2.*h(1:pks1(1)+searRange,j);
%                 [~, pks2] = findpeaks(abs(compVec2));
%             else
%                 pkloc2 = abs(h(pks1(1)-searRange:...
%                 pks1(1)+searRange,j)) > tolerance*max(abs(h(pks1(1)...
%                 -searRange:pks1(1)+searRange,j)));
%             
%                 compVec2 = pkloc2.*h(pks1(1)-searRange:pks1(1)+searRange,j);
%                 [~, pks2] = findpeaks(abs(compVec2));
%                 pks2 = pks2 + pks1(1)-searRange;
%             end
%             r(i,j) = 100*(pks1(1)-pks2(1))*(c/Fs);%Conversion from m
%             %to cm takes place
%         end
%     end
%     location = localize(r, p);
% end
