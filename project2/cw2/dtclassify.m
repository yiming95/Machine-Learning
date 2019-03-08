function label = dtclassify(decisionTree,sample)
a = decisionTree.class;
if (isempty(decisionTree.kids))
    label = a;
else 
    if sample(decisionTree.op(1))>= decisionTree.op(2)
        label = dtclassify(decisionTree.kids{2},sample);
    else
       label = dtclassify(decisionTree.kids{1},sample);
    end
end
