clear all;
p = [0 0 468 468 233; 0 470 470 0 0; 24 24 24 24 54];
carposx = randi(468,1,40);
carposy = randi(468,1,40);
carpos = [carposx; carposy];
Fs = 44100;
b = binit(44100, 10000, -1, 714, "50f1072b");
%f2d41e3c
tic
for k = 1:5
    location(:,k) = onlineTDOA(b,p,carpos(:,1));
end
intqrx = iqr(location(1,:));
intqry = iqr(location(2,:));
xoutliers = isoutlier(location(1,:));
youtliers = isoutlier(location(2,:));
outliers = xoutliers | youtliers;
locs = find(outliers == 0);
locationx = mean(location(1,locs));
locationy = mean(location(2,locs));
predicted_location = [locationx; locationy];
toc
disp(predicted_location-carpos(:,1));

% for k = 1:width(carpos)
%     disp(k);
%     location(:,k) = onlineTDOA(b, p, carpos(:,k));
% end

% plot(location(1,:), location(2,:), 'x');
% hold on;
% plot(carpos(1,:), carpos(2,:), 'o');
% 
% for i = 1:width(location)
%     error(i) = norm(carpos(:,i)-location(:,i));
% end
% average = mean(error);
% variance = var(error);
% disp("Mean error: "+average+"cm");
% disp("Variance: "+variance);

% for i=1:width(p)
%     subplot(width(p),1,i)
%     plot(h(:,i))
% end


