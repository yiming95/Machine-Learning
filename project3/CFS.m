% initial is x
% classes is y
function features = CFS(initial,classes)
k = 1;
[~,num_of_feature] = size(initial);

selected(1:132) = 0;
cur_max = 1000;
counter = 0;
maxdecreases = 3;
cor_new_features = 0;
cor_features = 0;
j = 1;

while 1

for i = 1 : num_of_feature
    if selected(i) == 1
        continue;
    else
        newfeature = Correlation(initial(:,i),classes);
        selectedf = find(selected == 1);
        for j = 1 : length(selectedf)
            selectedFeatures(j) = Correlation(initial(:,selectedf(j)),classes);
            cor_new_features(j) = Correlation(initial(:,selectedf(j)),initial(:,i));
        end
        if  isempty(selectedf)
            cor_classes_feat = Correlation(initial(:,i),classes);
            cor_new_features = 0;
        else
            cor_classes_feat = sum(selectedFeatures) + newfeature;
        end
        
        cfs(i) = cor_classes_feat / (k + 2*sum([cor_features cor_new_features]))^0.5;
        ff(i)  = sum(cor_new_features);
    end
end  

% set selected feature to -100 in order not to choose it again
cfs(find(selected == 1)) = -100;
% maxium value in the cfs formula of all features still in the initial set
% and its index
[maximum,index] = max(cfs);
selected(index) = 1;

cor_features = cor_features + ff(index);
% if 4 cfs values in row all drop, then stop
cfss(j) = maximum - cur_max;
j = j + 1;
k = k + 1;
if cur_max > maximum
    counter = counter + 1;
    decreases(counter) = index; 
else 
    counter = 0;
    decreases = [];
end

cur_max = maximum;

if counter >= maxdecreases
    break;
end

end
selected(decreases) = 0;
features = initial(:,selected == 1);

% choose the best two features
cfss(1) = 0;
[~,index_1] = max(cfss);
cfss(index_1) = 0;
[~,index_2] = max(cfss);

% plot the 2d graph
 gscatter(initial(:,index_1),initial(:,index_2),classes);
