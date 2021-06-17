%made by Hashim
function [x, hhat] = TDOA_Algorithm(transmission,receiver,position,Fs)
    N=size(receiver,2); %number of microphones
    tolerance=0.65;
    %calculate indexes
    for i=1:N %mode 0 = freq domain, mode 1 = match filter
        hhat(:,i)=decon(transmission, receiver(:,i), 1); 
    end
%     R= peak_detection(hhat,tolerance,position, Fs);
    
    %initialize left matrix
    A=zeros((N-1)*N/2,N+2);
    b=zeros((N-1)*N/2,1);
    k=1;
    for i=1:N-1
        for j=i+1:N
            R(i,j)=peaks_detection(hhat,tolerance,position, Fs, i, j);
            
            %fill left matrix
            A(k,1)=2*(position(1,j)-position(1,i));
            A(k,2)=2*(position(2,j)-position(2,i));
            A(k,3)=2*(position(3,j)-position(3,i));
            A(k,j+2)=-2*R(i,j);
            
            b(k)=R(i,j)^2-norm(position(:,i))^2+norm(position(:,j))^2;
            k=k+1;
        end
    end
    
   y=linsolve(A,b);
   x=[y(1);y(2)];
end