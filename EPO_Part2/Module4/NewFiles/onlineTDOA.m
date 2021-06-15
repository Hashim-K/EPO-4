%With filtering
% function location = onlineTDOA(b, p, carpos)
%     raw_data = micdata(b, p, carpos);
%     y = zeros(length(raw_data), width(raw_data));
%     for i = 1:width(raw_data)
%        y(:,i) = lowpass(raw_data(:,i),10000, b.Fs); 
%     end
%     refSig = refSignal(b,p);
%     h = decon(refSig, y, 1); %mode 0 = freq domain, mode 1 = match filter
%     location = TDOA(h, p, b.Fs);
% end

%Without filtering
function location = onlineTDOA(b, p, carpos)
    y = micdata(b, p, carpos);
    refSig = refSignal(b,p);
    h = decon(refSig, y, 1); %mode 0 = freq domain, mode 1 = match filter
    location = TDOA(h, p, b.Fs);
end