function h = raaklijn(x1,y1,r, Xpoint, Ypoint)
%Function for generating the tangent to circles. Taken from https://nl.mathworks.com/matlabcentral/answers/258780-how-to-plot-tangent-line-from-specified-point-to-a-circle


% % % % % PLOT TANGENTS TO A CIRCLE FROM A POINT OUTSIDE THE CIRCLE —
% % Reference: https://en.wikipedia.org/wiki/Law_of_cosines
a = linspace(0, 2*pi);                                              % Assign Angle Vector
                                                             % Circle Radius (‘a’)
ctr = [x1 y1];                                                    % Circle Centre
x = ctr(1) + r.*cos(a);                                             % Circle ‘x’ Vector
y = ctr(2) + r.*sin(a);                                             % Circle ‘y’ Vector
XY = [Xpoint Ypoint];                                                    % Point Outside Circle From Which Tangents Are Plotted
c = hypot(XY(1)-ctr(1),XY(2)-ctr(2));
if c <= r
    error('\n\tPOINT ON OR WITHIN CIRCLE RADIUS —> NO TANGENTS POSSIBLE!\n\n')
end
b = sqrt(c.^2 - r.^2);                                              % See Wikipedia Reference
alfa = acos((r.^2 - b.^2 - c.^2)./(-2*b*c));                        % See Wikipedia Reference
beta = acos((b.^2 - r.^2 - c.^2)./(-2*r*c));                        % See Wikipedia Reference
pt_ctr_angl = atan2(-(XY(2)-ctr(2)),-(XY(1)-ctr(1)));               % Angle From ‘Point’ To Circle Centre
alfac = [pt_ctr_angl + alfa; pt_ctr_angl - alfa];                   % Angles From ‘Point’ For Tangents
xtng = XY(1) + [b.*cos(alfac(1)); b.*cos(alfac(2))];                % Tangent Point ‘x’ Coordinates
ytng = XY(2) + [b.*sin(alfac(1)); b.*sin(alfac(2))];                % Tangent Point ‘y’ Coordinates
%figure(1)
%plot(x, y)                                                          % Plot Circle
%hold on
%plot(XY(1), XY(2), 'bp')                                            % Plot ‘Point’
%plot([XY(1) xtng(1)], [XY(2) ytng(1)])                              % Plot Tangents
%plot([XY(1) xtng(2)], [XY(2) ytng(2)])   %second one always longer imo                           % Plot Tangents
%hold off
grid
axis equal 
h = [xtng(1), ytng(1); xtng(2), ytng(2)];
end