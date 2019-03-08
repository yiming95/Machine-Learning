% script to calculate recall, precision and F1 measure

result = a;
b = transpose(a);
for i = 1:6
    recall(i) = b(i,i)/sum(b(:,i));
    precision(i) = b(i,i)/sum(b(i,:));
    fmeasure(i) = Fmeasure(precision(i),recall(i));
end