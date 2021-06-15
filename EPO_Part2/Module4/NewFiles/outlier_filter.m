function predicted_location = outlier_filter(location)
    xoutliers = isoutlier(location(1,:));
    youtliers = isoutlier(location(2,:));
    outliers = xoutliers | youtliers;
    locs = find(outliers == 0);
    locationx = mean(location(1,locs));
    locationy = mean(location(2,locs));
    predicted_location = [locationx; locationy];
end