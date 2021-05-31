function h = decon(x, Y, mode)
    if mode == 0
        for i = 1:width(Y)
            h(:,i) = deconfd(x, Y(:,i), 0);
        end
    else if mode == 1
        for i = 1:width(Y)
            h(:,i) = deconmf(x, Y(:,i));
        end 
        else
            disp("Error: Give a mode");
            return
        end
    end
end