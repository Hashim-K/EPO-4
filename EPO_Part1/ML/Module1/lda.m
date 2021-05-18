function [class,Ztest]=lda(Xtest, Xtrain, Ytrain)
% function [class]=lda(Xtest, Xtrain, Ytrain)

label= unique(Ytrain);

Xtrain = Xtrain-mean(Xtrain); % compute the group mean of input data
Xc_1 = Xtrain(find(Ytrain==label(1)),:);
Xc_2 = Xtrain(find(Ytrain==label(2)),:);

mean_1 = mean(Xc_1);
mean_2 = mean(Xc_2);

S_1 = Xc_1'*Xc_1;
S_2 = Xc_2'*Xc_2;

Sw  = S_1 + S_2;
w_fisher = inv(Sw)*((mean_1-mean_2)');
w_fisher = w_fisher/norm(w_fisher);
    
fisher_training_1 = w_fisher'*Xc_1';
fisher_training_2 = w_fisher'*Xc_2';
mean_fisher_1 = mean(fisher_training_1);
var_fisher_1  = cov(fisher_training_1);
mean_fisher_2 = mean(fisher_training_2);
var_fisher_2  = cov(fisher_training_2);

% Classification using Fisher  

Ztest = w_fisher'*Xtest';
    
class = zeros(size(Xtest,1),1);
for i = 1:size(Ztest,2);
    %if normpdf(Ztest(i), mean_fisher_1, sqrt(var_fisher_1)) >= normpdf(Ztest(i), mean_fisher_2, sqrt(var_fisher_2))
    if  norm(Ztest(i)-mean_fisher_1)/var_fisher_1 <= norm(Ztest(i)-mean_fisher_2)/var_fisher_2
        class(i)=label(1);
    else
        class(i)=label(2);
    end
end
