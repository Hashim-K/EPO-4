function h = circle(x,y,r)
%function for generating a circle with radius r around (x,y). Used in the
%routing algorithm. h is a array with points on the circle
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = [xunit; yunit];
end