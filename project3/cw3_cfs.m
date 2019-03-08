% correlation based feature selection
% transfor data
load('emotions_data_66.mat');
y1 = label2bin(1,y);
y2 = label2bin(2,y);
y3 = label2bin(3,y);
y4 = label2bin(4,y);
y5 = label2bin(5,y);
y6 = label2bin(6,y);

% 6 2d plots by using two important features selected by cfs
figure(1);
CFStraining1 = CFS(x,y1);
hold on;

figure(2);
CFStraining2 = CFS(x,y2);
hold on;

figure(3);
CFStraining3 = CFS(x,y3);
hold on;

figure(4);
CFStraining4 = CFS(x,y4);
hold on;

figure(5);
CFStraining5 = CFS(x,y5);
hold on;

figure(6);
CFStraining6 = CFS(x,y6);
hold on;

% 10-fold cross validation function applying 6 trees where each tree's
% training sample has been reduced demen by 
result = zeros(6);
[M,~] = size(CFStraining1);     
indices = crossvalidation(10,M);
for i = 1:10
    test_data = (indices==i);
    train_data = ~test_data; 
    
%train data for tree 1 to tree 6
trainData1 = CFStraining1(train_data,:);
trainData2 = CFStraining2(train_data,:);
trainData3 = CFStraining3(train_data,:);
trainData4 = CFStraining4(train_data,:);
trainData5 = CFStraining5(train_data,:);
trainData6 = CFStraining6(train_data,:);

% use function label2bin to trasfer the input data y (ranges from 1to 6) to
% y1 to y6 where are vectors only contain elements 0,1
% train target for tree 1 to tree 6
trainTarget = y(train_data,:);
Targets1 = label2bin(1,trainTarget);
Targets2 = label2bin(2,trainTarget);
Targets3 = label2bin(3,trainTarget);
Targets4 = label2bin(4,trainTarget);
Targets5 = label2bin(5,trainTarget);
Targets6 = label2bin(6,trainTarget);

% test data for tree 1 to tree 6
testData1 = CFStraining1(test_data,:);
testData2 = CFStraining2(test_data,:);
testData3 = CFStraining3(test_data,:);
testData4 = CFStraining4(test_data,:);
testData5 = CFStraining5(test_data,:);
testData6 = CFStraining6(test_data,:);

% test target for tree 1 to tree 6
testTarget = y(test_data,:);

% build tree1 to tree 6
Target_Attribute = 1 : 132;

[~,n1] = size(CFStraining1);
Attributes1 = ones(1,n1);
[~,n2] = size(CFStraining2);
Attributes2 = ones(1,n2);
[~,n3] = size(CFStraining3);
Attributes3 = ones(1,n3);
[~,n4] = size(CFStraining4);
Attributes4 = ones(1,n4);
[~,n5] = size(CFStraining5);
Attributes5 = ones(1,n5);
[~,n6] = size(CFStraining6);
Attributes6 = ones(1,n6);

Tree1 = CreateDecisionTree( trainData1, Targets1, Target_Attribute, Attributes1 );
Tree2 = CreateDecisionTree( trainData2, Targets2, Target_Attribute, Attributes2 );
Tree3 = CreateDecisionTree( trainData3, Targets3, Target_Attribute, Attributes3 );
Tree4 = CreateDecisionTree( trainData4, Targets4, Target_Attribute, Attributes4 );
Tree5 = CreateDecisionTree( trainData5, Targets5, Target_Attribute, Attributes5 );
Tree6 = CreateDecisionTree( trainData6, Targets6, Target_Attribute, Attributes6 );

% output for tree 1 using test data as sample data 
[m,~] = size(testData1);
 for j = 1: m 
    label = dtclassify(Tree1,testData1(j,:));
    output_1(j,1) = str2double(label);
 end
% output for tree 2 using test data
 for j = 1: m 
    label = dtclassify(Tree2,testData2(j,:));
    output_2(j,1) = str2double(label);
 end
% output for tree 3 using test data
  for j = 1: m 
    label = dtclassify(Tree3,testData3(j,:));
    output_3(j,1) = str2double(label);
  end
% output for tree 4 using test data
  for j = 1: m 
    label = dtclassify(Tree4,testData4(j,:));
    output_4(j,1) = str2double(label);
  end
% output for tree 5 using test data
  for j = 1: m
    label = dtclassify(Tree5,testData5(j,:));
    output_5(j,1) = str2double(label);
  end
% output for tree 6 using test data
  for j = 1: m
    label = dtclassify(Tree6,testData6(j,:));
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
 
 % find the data in the output which are [0,0,0,0,0,0] and random assign from 1-6 them as they don't make
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