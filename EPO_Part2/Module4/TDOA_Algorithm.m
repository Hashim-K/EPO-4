%made by Hashim
function [x, A, b, R, y, hhat] = TDOA_Algorithm(transmission,receiver,position,Fs)
    N=height(receiver); %number of microphones

    %calculate indexes
    for i=1:N
        hhat(i,:)=deconmf(transmission,receiver(i,:));
        [maxA,delay(i)]=max(hhat(i,:));
        index(i)=find( hhat(i,:)>0.8*maxA, 1 )-1;
        %d(i)=(343*index(i)/Fs);
    end
    disp(delay);
    disp(index);
    %initialize left matrix
    A=zeros((N-1)*N/2,N+1);
    b=zeros((N-1)*N/2,1);
    k=1;
    for i=1:N-1
        for j=i+1:N
            %calculate R pairs
            R(i,j)=calcD(index(i),index(j),Fs); 
            
            %fill left matrix
            A(k,1)=2*(position(j,1)-position(i,1));
            A(k,2)=2*(position(j,2)-position(i,2));
            A(k,j+1)=-2*R(i,j);
            
            b(k)=R(i,j)^2-norm(position(i,:))^2+norm(position(j,:))^2;
            k=k+1;
        end
    end
    
   y=linsolve(A,b);
   x=[y(1),y(2)];
end