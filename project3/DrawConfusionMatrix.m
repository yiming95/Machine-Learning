function confusion_matrix = DrawConfusionMatrix(target,predicted_target)
% this function is implemented to create confusion matrix
% the input are expected output and actual output
% the output is a 6*6 confusion matrix and if there are more than one true
% positive found in one set of data, it will commit the first found one.

[~,n] = size(target);  
matrix = zeros(6);
[~,I] = max(predicted_target,[],1);  
for j = 1:n
     matrix(I(j),j) = 1;   
end
[~,expected] = max(target,[],1);
[~,predicted] = max(matrix,[],1);
order = [1 2 3 4 5 6];
[confusion_matrix,order] = confusionmat(expected, predicted, 'order', order);




  













