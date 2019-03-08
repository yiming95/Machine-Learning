% Examples should be 612 * 132 double used for traning data.
% Targets should be 1*132 double.
% Target_Attribute should be the label for attributes which is 1*132 array
% Attributes are 1*132 array all elements are: 1 means active,0 means negative 

function [ tree ] = CreateDecisionTree( Examples, Targets, Target_Attribute, Attributes )

% create a root node for the tree
% op: the attribute that the node is testing
% kids: a cell array 1*2 which contains left subtree and right subtree
% class: a label for the returning class

tree = struct('op','null','kids',{},'class','null');
tree(1).kids = {};
numberTargets = length(Targets);
sumTargets = sum(Targets(:,1));

%If all targets of the examples is 1, then return the single-node tree Root of label 1

if sumTargets == numberTargets
    tree.class = '1';
    return
end

% If all targets of examples is 0, then return the single-node tree Root of label 0
if sumTargets == 0
      tree.class = '0';
    return
end

% If number of predicting attributes is empty, then Return the single node tree Root, 
% with label = most common value of the target attribute in the examples.
if (sum(Attributes) == 0)
    if (sumTargets >= numberTargets / 2)
        tree.class = '1';
    else
        tree.class = '0';
    end
    return
end
 
bestAttribute = bestFeature(Examples,Targets,Attributes);
tree.op = [Target_Attribute(bestAttribute(1)),bestAttribute(2)];
Attributes(bestAttribute(1)) = 0;

% split examples and targets into two branches under the root using bestThreshold 
examples_left = Examples(Examples(:,bestAttribute(1))< bestAttribute(2),:);
examples_right = Examples(Examples(:,bestAttribute(1))>= bestAttribute(2),:);
targets_left = Targets(Examples(:,bestAttribute(1))< bestAttribute(2),1);
targets_right = Targets(Examples(:,bestAttribute(1))>= bestAttribute(2),1);

% left subtree: samller than bestThreashold
if (isempty(examples_left))
    if (sumTargets >= numberTargets / 2) 
        tree.class = '1';
    else
        tree.class = '0';
    end
    return
else
    % recursion
    tree.kids{1} = CreateDecisionTree(examples_left, targets_left, Target_Attribute, Attributes);
end

%right subtree: greater than bestThreashold
if (isempty(examples_right))
    if (sumTargets >= numberTargets / 2) 
        tree.class = '1';
    else
        tree.class = '0';
    end
    return
else
    % recursion
    tree.kids{2} = CreateDecisionTree(examples_right, targets_right, Target_Attribute, Attributes);
end

end