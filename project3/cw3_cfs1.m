% correlation based feature selection
load('emotions_data_66.mat');
% 10-fold cross validation function applying 6 trees where each tree's
% training sample has been reduced demen by 
result = zeros(6);
[M,~] = size(x);     
indices = crossvalidation(10,M);
for i = 1:10
    test_data = (indices==i);
    train_data = ~test_data; 

% apply for loop for tree 1 to tree 6

for treenum = 1:6     
yTree = label2bin(treenum,y);
%2d plot by using two important features selected by cfs
figure(treenum);
CFStraining = CFS(x,yTree);
hold on;  

%train data for tree 1 to tree 6
trainData = CFStraining(train_data,:);
% use function label2bin to trasfer the input data y (ranges from 1to 6) to vectors only contain elements 0,1
% train target for tree
trainTarget = y(train_data,:);
Targets = label2bin(treenum,trainTarget);
% test data for tree
testData = CFStraining(test_data,:);
% test target for tree 
testTarget = y(test_data,:);

% build tree
Target_Attribute = 1 : 132;
[~,n1] = size(CFStraining);
Attributes = ones(1,n1);
Tree = CreateDecisionTree( trainData, Targets, Target_Attribute, Attributes);

% output for tree using test data as sample data 
[m,~] = size(testData);
 for j = 1: m 
    label = dtclassify(Tree,testData(j,:));
    yOutput(j,treenum) = str2double(label);
 end
 yTotal(:,treenum) = label2bin(treenum,testTarget); 
 % make these values empty as sometimes the size is 61*1, and sometimes it
 % can be 62*1, so it has to be clear. 
end

 yTotal_1 = transpose(yTotal);
 yOutput_1 = transpose(yOutput); 
 yTotal = [];
 yOutput = [];
 
 % find the data in the output which are [0,0,0,0,0,0] and contains multiple 1 and random assign from 1-6 
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