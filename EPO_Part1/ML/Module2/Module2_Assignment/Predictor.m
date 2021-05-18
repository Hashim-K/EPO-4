clear all;
load mymodel_test.mat;
Fs = 8000;
win = 20e-3;
threshold = 0.1;
L = Fs*win;
ov = 0.5*L;
%----------Recording Section-------------%
recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')

recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');

y = getaudiodata(recObj);
%----------------------------------------%
tic;
% extract feat
x_test = ExtractFeat(y, Fs, L, ov, threshold);

% standard normalize 
x_test = (x_test-mu_train)./sigma_train;


% predic
y_test_pred = model.predict(x_test)
toc;