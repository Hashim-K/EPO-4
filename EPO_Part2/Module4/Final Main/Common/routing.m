function out = routing(radius, waypoint_1, start, endpoint)
%Function for making a route betweeen a start, waypoint and endpoint given
%a certain turnradius of the car


%make linear lines from start to waypoint
a = linspace(start(1), waypoint_1(1)); 
b = linspace(start(2), waypoint_1(2));
line1 = [a; b];

a = linspace(waypoint_1(1), endpoint(1));
b = linspace(waypoint_1(2), endpoint(2));
line2 = [a; b];


line3 = [a; b];





%making unit vector which points to the direction the car is following in
%the first part (driving from start to waypoint)
a = [waypoint_1(1) - start(1), waypoint_1(2) - start(2)]/sqrt(((waypoint_1(1) - start(1))^2 + (waypoint_1(2) - start(2))^2))
a1 = [-1*a(2), a(1)] %unit vector turned +90 degrees from line
a2 = [a(2), -1*a(1)] %unit vector turned -90 degrees from line

%generating the two circles around the waypoint
R1 = [waypoint_1(1) + radius*a1(1), waypoint_1(2) + radius*a1(2)]
c1 = circle(R1(1), R1(2), radius);
R2 = [waypoint_1(1) + radius*a2(1), waypoint_1(2) + radius*a2(2)]
c2 = circle(R2(1), R2(2), radius);



%alle raaklijnen maken en linspaces plotten
h1 = raaklijn(R1(1),R1(2),radius, endpoint(1), endpoint(2))

h2 = raaklijn(R2(1),R2(2),radius, endpoint(1), endpoint(2))
l11 = [linspace(h1(1,1), endpoint(1)); linspace(h1(1,2), endpoint(2)) ];
l12 = [linspace(h1(2,1), endpoint(1)); linspace(h1(2,2), endpoint(2)) ];
l21 = [linspace(h2(1,1), endpoint(1)); linspace(h2(1,2), endpoint(2)) ];
l22 = [linspace(h2(2,1), endpoint(1)); linspace(h2(2,2), endpoint(2)) ];


%making vectors for not turing part
v1 = [h1(1,1) - R1(1); h1(1,2) - R1(2)]
v2 = [h1(2,1) - R1(1); h1(2,2) - R1(2)]
v3 = [h2(1,1) - R2(1); h2(1,2) - R2(2)]
v4 = [h2(2,1) - R2(1); h2(2,2) - R2(2)]

%determining where tangents from circles to endpoint direct to. So check if
%it is a possible route to follow
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

%check if the direction of the tangent points to the direction of which the
%car is driving around the circle. When that is the case it is a valid
%driving route
for i = 1:4
    if (sign(v(i,:)) == sign(s(i,:)))
        cor(i) = 1
    end
end


%filling correction matrix
for i = 1:4
    if(cor(i) == 1 && ((s(i,1)^2 + s(i,2)^2) < maxl))
        maxl = (s(i,1)^2 + s(i,2)^2);
        min = i;
    end
end


%looking up where the circles should start and end when given the start,
%waypoint and stop position
i = min;
        if(i == 1)
            path2(1,:) = l11(1,:);
            path2(2,:) = l11(2,:);
            endcircle(1) = h1(1,1) %endpoint of the circle
            endcircle(2) = h1(1,2)

        elseif(i == 2)
            path2(1,:) = l12(1,:);
            path2(2,:) = l12(2,:);
            endcircle(1) = h1(2,1) %endpoint of the circle
            endcircle(2) = h1(2,2)
        elseif(i == 3)
            path2(1,:) = l21(1,:);
            path2(2,:) = l21(2,:);
            endcircle(1) = h2(1,1) %endpoint of the circle
            endcircle(2) = h2(1,2)
        else
            path2(1,:) = l22(1,:);
            path2(2,:) = l22(2,:);
            endcircle(1) = h2(2,1) %endpoint of the circle
            endcircle(2) = h2(2,2)
        end

%determining if best possibility uses right or left circle
if (min <= 2)
    pathc(1,:) = c1(1,:);
    pathc(2,:) = c1(2,:);
    selected_circle = 0; %right or left circle
else
    pathc(1,:) = c2(1,:);
    pathc(2,:) = c2(2,:);
    selected_circle = 1;
end

%looking up which points of th 100 circle points to use in which order
tres = 2.5;
endc = 0; 
for i = 1:100
    if(abs(pathc(1,i) - waypoint_1(1)) < tres && abs(pathc(2,i) - waypoint_1(2)) < tres)
        beginc = i
    end
    
    if(abs(pathc(1,i) - endcircle(1)) < tres && abs(pathc(2,i) - endcircle(2)) < tres)
        endc = i;
    end
end

%making the final circel points
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

%calculating the direction the car points to for every point on the
%trajectory by calculating the derrivative wrt to time at each point
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
%output final path
out = path;
end