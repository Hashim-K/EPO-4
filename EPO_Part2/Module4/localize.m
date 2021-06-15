%Calvin's Script
% function location = localize(r, p)
%     N = width(r);
%     A = zeros((N-1)*N/2, N+1);
%     b = zeros((N-1)*N/2, 1);
%     k = 1;
%     for i = 1:N-1
%         for j = i+1:N
%             A(k,1) = 2*(p(1,j)-p(1,i));
%             A(k,2) = 2*(p(2,j)-p(2,i));
%             A(k,j+1) = -2*r(i,j);
%             b(k) = (r(i,j)^2)-(norm(p(:,i))^2)+(norm(p(:,j))^2);
%             k = k+1;
%         end
%     end
%     
%     result = (A\b);
%     location = [result(1); result(2)];
% end

function location = localize(r, p)
    N = width(r);
    A = zeros((N-1)*N/2, N+1);
    b = zeros((N-1)*N/2, 1);
    k = 1;
    for i = 1:N-1
        for j = i+1:N
            A(k,1) = 2*(p(1,j)-p(1,i));
            A(k,2) = 2*(p(2,j)-p(2,i));
            A(k,3) = 2*(p(3,j)-p(3,i));
            A(k,j+2) = -2*r(i,j);
            b(k) = (r(i,j)^2)-(norm(p(:,i))^2)+(norm(p(:,j))^2);
            k = k+1;
        end
    end
    
    result = (A\b);
    location = [result(1); result(2)];
end