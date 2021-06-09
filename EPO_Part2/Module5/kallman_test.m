clear;
X =[0;0;0;0];
P =zeros(4,4);
Y =[0;0];

noise_range = 10; 
noise_variance = 10; 

X_pred =[0;0;0;0;];
dt = 0.1; 
clf; 
Fx = 10; 
Fy = 5; 
for i = 1 : 10
    %Make a perfect measurement
    [ X_pred ] = predictor(X_pred,dt,Fx,Fy);
    
    
    n1 = -noise_range + 2*noise_range*rand();
    n2 = -noise_range + 2*noise_range*rand();
    %Add noise to the perfect measurement 
    Y = [ X_pred(1)+n1 ; X_pred(2)+n2]*rand();
    
    %Now do the kallman filter with the measurement
    [X,P,~ ] = kalmanfilter(X,Y,P,Fx,Fy,dt,noise_variance);

   
  %  plot(i,X_pred(3),'r*');
    hold on; 
    plot(Y(1),Y(2),'r*');
    hold on;
    plot(X(1),X(2),'bo');
    plot(X_pred(1),X_pred(2),'gv');
    xlim([-10,10]); 
    ylim([-10,10]);
    grid on; 
    
end 

Fx = 10; 
Fy = -10; 
for i = 1 : 10
    %Make a perfect measurement
    [ X_pred ] = predictor(X_pred,dt,Fx,Fy);
    
    
    n1 = -noise_range + 2*noise_range*rand();
    n2 = -noise_range + 2*noise_range*rand();
    %Add noise to the perfect measurement 
    Y = [ X_pred(1)+n1 ; X_pred(2)+n2];
    
    %Now do the kallman filter with the measurement
    [X,P,~ ] = kalmanfilter(X,Y,P,Fx,Fy,dt,noise_variance);

   
  %  plot(i,X_pred(3),'r*');
    hold on; 
    plot(Y(1),Y(2),'r*');
    hold on;
    plot(X(1),X(2),'bo');
    plot(X_pred(1),X_pred(2),'gv');
    xlim([-10,10]); 
    ylim([-10,10]);
    grid on; 
    
end 


