% pca
load('emotions_data_66.mat');
[coeff, score, latent] = pca(x);
%plot 2d graph, x-axis is PC1, y-axis is PC2
figure(1);
gscatter(score(:,1),score(:,2),y); 
hold on;
%a is used to know how many percents of variance has been covered 
a = cumsum(latent)./sum(latent); 
%testingOutput = bsxfun(@minus,score,mean(score))*coeff;
% to achieve 95% accurancy, PcaTraning and PcaTesting are re-arrangement
% data for training and testing by using PCA method
[m1,n1] = size(latent);
for i = 1:m1
  if a(i) < 0.95
      PcaTraining = score(:,1:i);
  end
end

% 10-fold cross validation function
result = zeros(6);
[M,N] = size(PcaTraining);     
indices = crossvalidation(10,M);
for i = 1:10
    test_data = (indices==i);
    train_data = ~test_data; 
    
%get trainData,trainTarget,testData,testTarget 
trainData = PcaTraining(train_data,:);
trainTarget = y(train_data,:);
testData = PcaTraining(test_data,:);
testTarget = y(test_data,:);

% for loop for tree 1 to tree 6
for treenum = 1:6    
% use function label2bin to trasfer the input data y 
yTree = label2bin(treenum,trainTarget);
% build tree
Examples = trainData;
Target_Attribute = 1 : 132;
Attributes = ones(1,132);
Targets = yTree;
Tree = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );

% output for tree using test data as sample data 
[m,n] = size(testData);
 for j = 1: m 
    label = dtclassify(Tree,testData(j,:));
    yOutput(j,treenum) = str2double(label);
 end

% combine six emotions testTargets into one matrix yTotal, and results
% into one matrix yOutout
 yTotal(:,treenum) = label2bin(treenum,testTarget); 
end

yTotal_1 = transpose(yTotal);
yOutput_1 = transpose(yOutput);
% make these values empty as sometimes the size is 61*1, and sometimes it
% can be 62*1, so it has to be clear.
yTotal = [];
yOutput = [];
% find the data in the output which are [0,0,0,0,0,0] and contains multiple 1
% then random assign a number from 1 to 6
rejected = sum(yOutput_1) == 0;
for k = 1 : sum(rejected == 1) 
    rejected_indexes = find(rejected == 1);
    yOutput_1(:,rejected_indexes(k)) = label2vec(randi(6));
end

ambiguilty = sum(yOutput_1);
 for k = 1 : sum(ambiguilty > 1)
     am_indexes = find(ambiguilty > 1);
     yOutput_1(:,am_indexes(k)) = label2vec(randi(ambiguilty(am_indexes(k))));
 end
 
% use DrawConfusionMatrix function to create the confusion matrix,
% result is the sum of ten confusion matrices and it is used in the evaluation.m  
 confusion_matrix = DrawConfusionMatrix(yTotal_1,yOutput_1);
 result = confusion_matrix + result;
end