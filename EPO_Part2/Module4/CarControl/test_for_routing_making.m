waypoint = [250,100]
start = [0,50]
endpos = [450,400]
radius = 50
direction = 270
path = routing(radius, waypoint, start, endpos)


x_coor = path(1,:);
y_coor = path(2,:);
plot(x_coor,y_coor)
            xlim([0, 600])
            ylim([0, 600])

hold on;

plot(start(1), start(2),'ro');
text(start(1), start(2),'\leftarrow startpoint')
plot(waypoint(1), waypoint(2),'ro');
text(waypoint(1), waypoint(2),'\leftarrow waypoint')
plot(endpos(1), endpos(2),'ro');
text(endpos(1), endpos(2),'\leftarrow endpoint')