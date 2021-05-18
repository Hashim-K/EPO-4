%made by Hashim
function x = TDOA_Algorithm(receiver,transmission,position,Fs)
    N=height(receiver); %number of microphones

    %calculate indexes
    for i=1:N
        hhat=deconfd(receiver(i),transmission);
        [maxA,delay(i)]=max(hhat);
        index(i)=delay(i)-1;
        %d(i)=(343*index(i)/Fs);
    end
    
    %initialize left matrix
    A=zeros((N-1)*N/2,N+1);
    b=zeros((N-1)*N/2,1);
    k=1;
    for i=1:N-1
        for j=i+1:N
            %calculate R pairs
            R(i,j)=calcD(index(i),index(j)); 
            
            %fill left matrix
            A(k,1)=2*(pos(j,1)-pos(i,1));
            A(k,2)=2*(pos(j,2)-pos(i,2));
            A(k,j+1)=-2*R(i,j);
            
            b(k)=R(i,j)^2-norm(position(i,:))^2+norm(position(j,:))^2;
            k=k+1;
        end
    end
    
   y=linsolve(A,b);
   x=y(1);
end