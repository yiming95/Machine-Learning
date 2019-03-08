function results = bestFeature(examples,labels,activeAttributes)
%This function helps to find the best feature and best threshold used at
%each decision point.

%input negative examples
n = sum(labels(:)==0);
%input positive examples
p = length(labels) - n;

%get the features and numbers of input data
[num,features] = size(examples);

%This loop compare the best gains among different features.
for i = 1 : features
   f_with_label(:,1) = examples(:,i);
   f_with_label(:,2) = labels;
   f_with_label = sortrows(f_with_label);

%This inner loop records the best gain from different thresholds.
   for j = 1 : num - 1
       
       true_p = sum(f_with_label(1:j,2) == 1);
       true_n = j - true_p;
       
       false_p = sum(f_with_label(j+1:num,2)==1);
       false_n = num - j - false_p;
       
       best(j,1) = gain(p,n,true_p,true_n,false_p,false_n);
       best(j,2) = (f_with_label(j,1) + f_with_label(j+1,1))/2;
    
   end
   [~,index] = max(best(:,1));
   gains_diff_feat(i,:) = best(index,:);
end
   [~,max_index] = max(gains_diff_feat(:,1));
   while(activeAttributes(max_index) == 0)
       gains_diff_feat(max_index,1) = -1000;
       [~,max_index] = max(gains_diff_feat(:,1));
   end
   bestThreshold = gains_diff_feat(max_index,2);
   bestFeature = max_index;
   results = [bestFeature,bestThreshold];
   
   
       

