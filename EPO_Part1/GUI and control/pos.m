


function x = pos(i)
            if (i == 0)
             kitt = car		% create a new car
             kitt.velocity = 3	% give it some speed
            end
             kitt			% update position based on velocity before displaying
             x = kitt.position		% also calculates position
end