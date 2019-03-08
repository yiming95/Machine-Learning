% script to calculate recall, precision and F1 measure
% result is the sum matrix in the cw2.m, it should appear at the workspace after running cw2.m
% the output of this program are recall, precision and f1 measure
a = result; 
b = transpose(a);
for i = 1:6
    recall(i) = b(i,i)/sum(b(:,i));
    precision(i) = b(i,i)/sum(b(i,:));
    fmeasure(i) = Fmeasure(precision(i),recall(i));
end