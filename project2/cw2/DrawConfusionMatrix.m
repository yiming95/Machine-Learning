function confusion_matrix = DrawConfusionMatrix(target,predicted_target)

testTarget = target;
t = predicted_target;
[m,n] = size(testTarget);  
matrix = zeros(6);
[Y,I] = max(t,[],1);  
for j = 1:n
     matrix(I(j),j) = 1;   
end
[P,expected] = max(testTarget,[],1);
[Q,predicted] = max(matrix,[],1);
order = [1 2 3 4 5 6];
[confusion_matrix,order] = confusionmat(expected, predicted, 'order', order);




  













