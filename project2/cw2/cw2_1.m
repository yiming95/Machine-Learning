% assignment 2: decision trees

% Examples should be 612 * 132 double used for traning data.
% Targets should be 1*132 double.
% Target_Attribute should be the label for attributes which is 1*132 array
% Attributes are 1*132 array all elements are: 1 means active,0 means negative 

load('emotions_data_66.mat');
y1 = label2bin(1,y);
y2 = label2bin(2,y);
y3 = label2bin(3,y);
y4 = label2bin(4,y);
y5 = label2bin(5,y);
y6 = label2bin(6,y);
Examples = x;
Targets = y1;
Target_Attribute = 1 : 132;
Attributes = ones(1,132);

% tree for target = 1
Tree1 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
DrawDecisionTree(Tree1,'tree 1');
% tree for target = 2
Targets = y2;
Tree2 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
DrawDecisionTree(Tree2,'tree 2');

% tree for target = 3
Targets = y3;
Tree3 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
DrawDecisionTree(Tree3,'tree 3');

% tree for target = 4
Targets = y4;
Tree4 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
DrawDecisionTree(Tree4,'tree 4');

% tree for target = 5
Targets = y5;
Tree5 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
DrawDecisionTree(Tree5,'tree 5');

% tree for target = 6
Targets = y6;
Tree6 = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes );
DrawDecisionTree(Tree6,'tree 6');

% output for tree 1 using x as sample data 
[m,n] = size(x);
 for i = 1: m 
    label = dtclassify(Tree1,x(i,:));
    output_1(i,1) = str2num(label);
 end
 for i = 1: m 
    label = dtclassify(Tree2,x(i,:));
    output_2(i,1) = str2num(label);
 end
  for i = 1: m 
    label = dtclassify(Tree3,x(i,:));
    output_3(i,1) = str2num(label);
  end
  for i = 1: m 
    label = dtclassify(Tree4,x(i,:));
    output_4(i,1) = str2num(label);
  end
  for i = 1: m 
    label = dtclassify(Tree5,x(i,:));
    output_5(i,1) = str2num(label);
  end
  for i = 1: m 
    label = dtclassify(Tree6,x(i,:));
    output_6(i,1) = str2num(label);
  end

  % combine 
 yTotal(:,1) = y1(:,1);
 yTotal(:,2) = y2(:,1);
 yTotal(:,3) = y3(:,1);
 yTotal(:,4) = y4(:,1);
 yTotal(:,5) = y5(:,1);
 yTotal(:,6) = y6(:,1);
 
 yOutput(:,1) = output_1(:,1);
 yOutput(:,2) = output_2(:,1);
 yOutput(:,3) = output_3(:,1);
 yOutput(:,4) = output_4(:,1);
 yOutput(:,5) = output_5(:,1);
 yOutput(:,6) = output_6(:,1);
 
 classes = eye(6);
 yTotal_1 = transpose(yTotal);
 yOutput_1 = transpose(yOutput);
 confusion_matrix = DrawConfusionMatrix_1(yTotal_1,yOutput_1,classes)
 