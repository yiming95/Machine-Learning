% assignment 2: decision trees

% Examples should be 612 * 132 double used for traning data.
% Targets should be 1*132 double.
% Target_Attribute should be the label for attributes which is 1*132 array
% Attributes are 1*132 array all elements are: 1 means active,0 means negative 
load('emotions_data_66.mat');
result = zeros(6);
% 10-fold cross validation function
[M,N] = size(x);     
indices = crossvalidation(10,M);
for i = 1:10
    test_data = (indices==i);
    train_data = ~test_data; 
    
%get trainData,trainTarget,testData,testTarget 
trainData = x(train_data,:);
trainTarget = y(train_data,:);
testData = x(test_data,:);
testTarget = y(test_data,:);

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
 for i = 1: m 
    label = dtclassify(Tree1,testData(i,:));
    output_1(i,1) = str2num(label);
 end
% output for tree 2 using test data
 for i = 1: m 
    label = dtclassify(Tree2,testData(i,:));
    output_2(i,1) = str2num(label);
 end
% output for tree 3 using test data
  for i = 1: m 
    label = dtclassify(Tree3,testData(i,:));
    output_3(i,1) = str2num(label);
  end
% output for tree 4 using test data
  for i = 1: m 
    label = dtclassify(Tree4,testData(i,:));
    output_4(i,1) = str2num(label);
  end
% output for tree 5 using test data
  for i = 1: m 
    label = dtclassify(Tree5,testData(i,:));
    output_5(i,1) = str2num(label);
  end
% output for tree 6 using test data
  for i = 1: m 
    label = dtclassify(Tree6,testData(i,:));
    output_6(i,1) = str2num(label);
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
 classes = eye(6);
 yTotal_1 = transpose(yTotal);
 yOutput_1 = transpose(yOutput);
 
 rejected = sum(yOutput_1) == 0;
 yOutput_1(:,rejected) = [];
 yTotal_1(:,rejected) = [];
 
 confusion_matrix = DrawConfusionMatrix(yTotal_1,yOutput_1)
 result = confusion_matrix + result;
 %figure,plotconfusion(yTotal_1,yOutput_1)
 yTotal = [];
 yOutput = [];

 %matrices = eye(6);
 %matrices(:,:,i) = confusion_matrix;
end
 %save('matrices.mat','matrices');
 
 