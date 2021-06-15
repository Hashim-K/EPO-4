clear all;
close all;
clc;

load modelFinalChall.mat;

Fs = 8000;
win = 20e-3;
threshold = 0.1;
L = Fs*win;
ov = 0.5*L;

recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')

recordblocking(recObj, 0.75); % do a 2 second recording (blocking)
disp('End of Recording.');

y = getaudiodata(recObj);

% extract feat
x_test = ExtractFeat(y, Fs, L, ov, threshold);

% standard normalize 
x_test = (x_test-mu_train)./sigma_train;

% predict
[y_test_pred, score] = model.predict(x_test);

disp(y_test_pred);
disp(score);