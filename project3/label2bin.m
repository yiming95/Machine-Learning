function labels = label2bin(labelnum,labels)
%This function help to set labels for binary classification.
%ones for certain emotion, zeros for other emotion
for i = 1 : length(labels)
    if labels(i) == labelnum
        labels(i) = 1;
    else
        labels(i) = 0;
    end
end