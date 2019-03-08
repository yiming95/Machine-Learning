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
      %PcaTesting = testingOutput(:,1:i);
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

% use function label2bin to trasfer the input data y (ranges from 1to 6) to
% y1 to y6 where are vectors only contain elements 0,1
y1 = label2bin(1,trainTarget);
y2 = label2bin(2,trainTarget);
y3 = label2bin(3,trainTarget);
y4 = label2bin(4,trainTarget);
y5 = label2bin(5,trainTarget);
y6 = label2bin(6,trainTarget);
Examples = trainData;
Target_Attribute = 1 : 132;
Attributes = ones(1,132);

% tree for target = 1
Targets = y1;
Tree1 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
%DrawDecisionTree(Tree1,'tree 1');
% tree for target = 2
Targets = y2;
Tree2 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
%DrawDecisionTree(Tree2,'tree 2');

% tree for target = 3
Targets = y3;
Tree3 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
%DrawDecisionTree(Tree3,'tree 3');

% tree for target = 4
Targets = y4;
Tree4 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
%DrawDecisionTree(Tree4,'tree 4');

% tree for target = 5
Targets = y5;
Tree5 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
%DrawDecisionTree(Tree5,'tree 5');

% tree for target = 6
Targets = y6;
Tree6 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
%DrawDecisionTree(Tree6,'tree 6');

% output for tree 1 using test data as sample data 
[m,n] = size(testData);
 for j = 1: m 
    label = dtclassify(Tree1,testData(j,:));
    output_1(j,1) = str2double(label);
 end
% output for tree 2 using test data
 for j = 1: m 
    label = dtclassify(Tree2,testData(j,:));
    output_2(j,1) = str2double(label);
 end
% output for tree 3 using test data
  for j = 1: m 
    label = dtclassify(Tree3,testData(j,:));
    output_3(j,1) = str2double(label);
  end
% output for tree 4 using test data
  for j = 1: m 
    label = dtclassify(Tree4,testData(j,:));
    output_4(j,1) = str2double(label);
  end
% output for tree 5 using test data
  for j = 1: m 
    label = dtclassify(Tree5,testData(j,:));
    output_5(j,1) = str2double(label);
  end
% output for tree 6 using test data
  for j = 1: m 
    label = dtclassify(Tree6,testData(j,:));
    output_6(j,1) = str2double(label);
  end

% combine six emotions testTargets into one matrix yTotal, and results
% into one matrix yOutout
 y1_1 = label2bin(1,testTarget); 
 y2_1 = label2bin(2,testTarget);
 y3_1 = label2bin(3,testTarget);
 y4_1 = label2bin(4,testTarget);
 y5_1 = label2bin(5,testTarget);
 y6_1 = label2bin(6,testTarget);
 yTotal = [y1_1 y2_1 y3_1 y4_1 y5_1 y6_1];
 yOutput = [output_1 output_2 output_3 output_4 output_5 output_6];
 yTotal_1 = transpose(yTotal);
 yOutput_1 = transpose(yOutput);
 
 % find the data in the output which are [0,0,0,0,0,0] and delete them as they don't make
 % sense when create the confusion matrix and evaluation.
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

 % make these values empty as sometimes the size is 61*1, and sometimes it
 % can be 62*1, so it has to be clear.
 yTotal = [];
 yOutput = [];
 output_1 = [];
 output_2 = [];
 output_3 = [];
 output_4 = [];
 output_5 = [];
 output_6 = [];
end