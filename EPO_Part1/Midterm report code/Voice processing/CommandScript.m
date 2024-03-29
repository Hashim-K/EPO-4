clear all;
close all;
clc;

% load('datarec_directions.mat');
load NewData.mat;
% data = [DownM,DownW,LeftM,LeftW,RightM,RightW,UpM,UpW];
data = [Ini, Go, Halt];
Fs = 8000;
win = 20e-3;
threshold = 0.1;
L = Fs*win;
ov = 0.5*L;

num_samples=size(data,2);
num_feat=11;

% matrix for recording the features
X=zeros(num_samples, num_feat);

% Extracting the features
for i=1:size(data,2)
    
    y = data(:,i);
    X(i,:)=ExtractFeat(y,Fs,L,ov,threshold);
    
end

% Y=[ones(20,1);2.*ones(20,1);3.*ones(20,1);4.*ones(20,1)];
Y = [ones(20,1);2.*ones(20,1);3.*ones(20,1)];

percent_train_split=100/100;
[train_id,test_id]=train_test_split(Y,percent_train_split);

% splitting the inputs
Xtrain=X(train_id,:);
Xtest=X(test_id,:);

% splitting the labels
Ytrain=Y(train_id,:);
Ytest=Y(test_id,:);

[Xtrain,mu_train,sigma_train] = zscore(Xtrain);

Xtest= (Xtest-mu_train)./sigma_train;

[idx,scores] = fscmrmr(Xtrain,Ytrain);


%---------Predictor Score Bar Chart------%
figure;bar(idx,scores(idx))%Create bar graph
xlabel('Feature')
set(gca,'TickLabelInterpreter','latex');
ylabel('Predictor Score'); hold off;
%----------------------------------------%

rng default
% number of trees
nTrees = 40;

% Train the TreeBagger (Random Forest).
model = TreeBagger( nTrees,Xtrain,Ytrain ...
    , 'Method', 'classification');
save('mymodel2.mat','model','mu_train','sigma_train');
%----------Confusion Matrix Section------%
% Ytest_pred_str = model.predict(Xtest);
% Ytest_pred = str2double(Ytest_pred_str);
% num_classes=length(unique(Y));
% 
% Ytest_cat=zeros(num_classes,size(Ytest,1));
% Ytest_pred_cat=zeros(num_classes,size(Ytest,1));
% 
% for i=1:num_classes
%     Ytest_cat(i, Ytest==i) = 1;
%     Ytest_pred_cat(i, Ytest_pred==i) = 1;
% end
% 
% figure; plotconfusion(Ytest_cat,Ytest_pred_cat); hold off;
%----------------------------------------%

%----------Recording Section-------------%
recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')

recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');

y = getaudiodata(recObj);
%----------------------------------------%

% extract feat
x_test = ExtractFeat(y, Fs, L, ov, threshold);

% standard normalize 
x_test = (x_test-mu_train)./sigma_train;

% predict
y_test_pred = model.predict(x_test)
