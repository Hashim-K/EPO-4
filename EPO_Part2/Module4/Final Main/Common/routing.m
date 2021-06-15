function out = routing(radius, waypoint_1, start, endpoint)

% radius = 30;
% waypoint_1 = [250,100];
% start = [0,0];
% endpoint = [00,400];

%plot(waypoint_1(1), waypoint_1(2),'r+');
%hold on;
%plot(endpoint(1), endpoint(2),'r+');
%hold on;
a = linspace(start(1), waypoint_1(1));
b = linspace(start(2), waypoint_1(2));
line1 = [a; b];

a = linspace(waypoint_1(1), endpoint(1));
b = linspace(waypoint_1(2), endpoint(2));
line2 = [a; b];


line3 = [a; b];

%plot(line1(1,:), line1(2,:))
%hold on;
%%plot(line2(1,:), line2(2,:))
%plot(line3(1,:), line3(2,:))






a = [waypoint_1(1) - start(1), waypoint_1(2) - start(2)]/sqrt(((waypoint_1(1) - start(1))^2 + (waypoint_1(2) - start(2))^2))
a1 = [-1*a(2), a(1)] %unit vector turned +90 degrees from line
a2 = [a(2), -1*a(1)] %unit vector turned -90 degrees from line

R1 = [waypoint_1(1) + radius*a1(1), waypoint_1(2) + radius*a1(2)]
c1 = circle(R1(1), R1(2), radius);
R2 = [waypoint_1(1) + radius*a2(1), waypoint_1(2) + radius*a2(2)]
c2 = circle(R2(1), R2(2), radius);

%plot(c1(1,:), c1(2,:));
%plot(c2(1,:), c2(2,:));

%hold on; %alle raaklijnen maken en linspaces plotten
h1 = raaklijn(R1(1),R1(2),radius, endpoint(1), endpoint(2))
%hold on;
h2 = raaklijn(R2(1),R2(2),radius, endpoint(1), endpoint(2))
l11 = [linspace(h1(1,1), endpoint(1)); linspace(h1(1,2), endpoint(2)) ];
l12 = [linspace(h1(2,1), endpoint(1)); linspace(h1(2,2), endpoint(2)) ];
l21 = [linspace(h2(1,1), endpoint(1)); linspace(h2(1,2), endpoint(2)) ];
l22 = [linspace(h2(2,1), endpoint(1)); linspace(h2(2,2), endpoint(2)) ];


%hold on;
%plot(l11(1,:), l11(2,:))
%hold on;
%plot(l12(1,:), l12(2,:))
%hold on;
%plot(l21(1,:), l21(2,:))
%hold on;
%plot(l22(1,:), l22(2,:))
%hold on;

%goede vectors voor niet draaien
v1 = [h1(1,1) - R1(1); h1(1,2) - R1(2)]
v2 = [h1(2,1) - R1(1); h1(2,2) - R1(2)]
v3 = [h2(1,1) - R2(1); h2(1,2) - R2(2)]
v4 = [h2(2,1) - R2(1); h2(2,2) - R2(2)]

v(1,:) = [-1*v1(2), v1(1)] / sqrt(((h1(1,1) - R1(1))^2 + (h1(1,2) - R1(2))^2))
v(2,:) = [-1*v2(2), v2(1)] / sqrt(((h1(2,1) - R1(1))^2 + (h1(2,2) - R1(2))^2))
v(3,:) = [v3(2), -1*v3(1)] / sqrt(((h2(1,1) - R2(1))^2 + (h2(1,2) - R2(2))^2))
v(4,:) = [v4(2), -1*v4(1)] / sqrt(((h2(2,1) - R2(1))^2 + (h2(2,2) - R2(2))^2))

s(1,:) = [endpoint(1) - h1(1,1), endpoint(2) - h1(1,2)]
s(2,:) = [endpoint(1) - h1(2,1), endpoint(2) - h1(2,2)]
s(3,:) = [endpoint(1) - h2(1,1), endpoint(2) - h2(1,2)]
s(4,:) = [endpoint(1) - h2(2,1), endpoint(2) - h2(2,2)]


cor = zeros(1,4)

min = 0;
maxl = 9999999;


for i = 1:4
    if (sign(v(i,:)) == sign(s(i,:)))
        cor(i) = 1
    end
end



for i = 1:4
    if(cor(i) == 1 && ((s(i,1)^2 + s(i,2)^2) < maxl))
        maxl = (s(i,1)^2 + s(i,2)^2);
        min = i;
    end
end



i = min;
        if(i == 1)
            %hold on;
            
            path2(1,:) = l11(1,:);
            path2(2,:) = l11(2,:);
            endcircle(1) = h1(1,1) %endpoint of the circle
            endcircle(2) = h1(1,2)
            %%plot(l11(1,:), l11(2,:))

        elseif(i == 2)
            %hold on;
            path2(1,:) = l12(1,:);
            path2(2,:) = l12(2,:);
            endcircle(1) = h1(2,1) %endpoint of the circle
            endcircle(2) = h1(2,2)
            %%plot(l12(1,:), l12(2,:))
        elseif(i == 3)
            %hold on;
            path2(1,:) = l21(1,:);
            path2(2,:) = l21(2,:);
            endcircle(1) = h2(1,1) %endpoint of the circle
            endcircle(2) = h2(1,2)
            %%plot(l21(1,:), l21(2,:))
        else
            %hold on;
            path2(1,:) = l22(1,:);
            path2(2,:) = l22(2,:);
            endcircle(1) = h2(2,1) %endpoint of the circle
            endcircle(2) = h2(2,2)
            %%plot(l22(1,:), l22(2,:))
        end




%hold on;
%%plot(line1(1,:), line1(2,:))
%hold on;

if (min <= 2)
    %%plot(c1(1,:), c1(2,:));
    pathc(1,:) = c1(1,:);
    pathc(2,:) = c1(2,:);
    selected_circle = 0; %right or left circle
else
    %%plot(c2(1,:), c2(2,:));
    pathc(1,:) = c2(1,:);
    pathc(2,:) = c2(2,:);
    selected_circle = 1;
end

tres = 2.5;
for i = 1:100
    if(abs(pathc(1,i) - waypoint_1(1)) < tres && abs(pathc(2,i) - waypoint_1(2)) < tres)
        beginc = i
    end
    
    if(abs(pathc(1,i) - endcircle(1)) < tres && abs(pathc(2,i) - endcircle(2)) < tres)
        endc = i;
    end
end

if(selected_circle == 0)
    if (beginc > endc)
        path(1,:) = [line1(1,:) pathc(1,beginc:100) pathc(1,1:endc) path2(1,:)];
        path(2,:) = [line1(2,:) pathc(2,beginc:100) pathc(2,1:endc) path2(2,:)];
        a=1
    else
        path(1,:) = [line1(1,:) pathc(1,beginc:endc) path2(1,:)];
        path(2,:) = [line1(2,:) pathc(2,beginc:endc) path2(2,:)];
        a=2
    end
else
    if (beginc > endc)
        k1 = pathc(1,endc:beginc); %reverse order shuch that points are in correct order
        k1 = flip(k1)
        k2 = pathc(2,endc:beginc);
        k2 = flip(k2)
        path(1,:) = [line1(1,:) k1 path2(1,:)];
        path(2,:) = [line1(2,:) k2 path2(2,:)];
        a=3
    else
        path(1,:) = [line1(1,:) pathc(1,beginc:endc) path2(1,:)];
        path(2,:) = [line1(2,:) pathc(2,beginc:endc) path2(2,:)];
        a=4
    end
    
end

%figure(3)
%plot(path(1,:), path(2,:));

path(3,1) = 0;
for i = 2:length(path(1,:)) %making third entry equal to angle
    dy = (path(2,i) - path(2,i-1));
    dx = (path(1,i) - path(1,i-1));
    path(3,i) = dy / dx;
    
    path(3,i) = atan(path(3,i));
    
    if(dx < 0) %calculating angle also for second and third quadrant.
        path(3,i) = path(3,i) + pi;
    elseif(dy < 0) %calculating also for 4th quadrant
        path(3,i) = path(3,i) + 2*pi;
    end
    path(3,i) = path(3,i)*180/pi;
    if(path(3,i) - path(3,i-1) > 30 || path(3,i) - path(3,i-1) < -30)
        path(3,i) = path(3,i-1);
    end
end
%hold on;
%plot(waypoint_1(1), waypoint_1(2),'r+');
out = path;
end