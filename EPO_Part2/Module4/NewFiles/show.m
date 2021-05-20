function show(x)
    %Simple plot function;
    for i=1:width(x)
        subplot(width(x),1,i);
        plot(x(:,i));
    end
end