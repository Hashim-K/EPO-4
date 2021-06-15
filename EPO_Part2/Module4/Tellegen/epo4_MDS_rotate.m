    function X=epo4_MDS_rotate(X,dim,order)
	% function X=epo4_MDS_rotate(X,dim,order)
    % X is the rotated answer of MDS 3(2) x nChan
    % dim is 2 or 3 
    % order: is the order of the points, 1 is (0,0,0) 2 is (+x,0,0)
    % third is (0,+y,0) and so on ..
    
	if(dim ==3)
        %rotate the z for the second point
        d=X(:,order(1))-X(:,order(2));
        d=d/norm(d);
        Q=planerot(d(2:3,order(1)));
        X=[1,zeros(1,2);zeros(2,1),Q]*X;
        
        %rotate the y for the second point
        d=X(:,order(1))-X(:,order(2));
        d=d/norm(d);
        Q=planerot(d(1:2,order(1)));
        X=[Q,zeros(2,1);zeros(1,2),1]*X;
        
        %rotate the z for the third point 
        d=X(:,order(1))-X(:,order(3));
        d=d/norm(d);
        Q=planerot(d(2:3,order(1)));
        X=[1,zeros(1,2);zeros(2,1),Q]*X;
        % now points 2 has the same y and z as point 1
        % also point 3 has the same z as point 1 and 2
    else
        %rotate the y for the second point
        d=X(:,order(1))-X(:,order(2));
        d=d/norm(d);
        Q=planerot(d(1:2,order(1)));
        X=Q*X;
    end
    %make sure x of second point is positive
    if (X(1,order(2))<X(1,order(1)))
        X=-X;
    end
    % Translate point 1 to (0,0)
    X(1,:)=X(1,:)-X(1,order(1));
    X(2,:)=X(2,:)-X(2,order(1));
    %make sure y of third point is pisitive
    if(X(2,order(3))<0)
        X(2,:)=-X(2,:);
    end
    if(dim==3)
        X(3,:)=X(3,:)-X(3,1);
        %make sure that the maximum z corresponds to a positive z
        [v,l]=max(abs(X(3,:)));
        if(X(3,l)<0)
            X(3,:)=-X(3,:);
        end
    end
end
