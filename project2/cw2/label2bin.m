function labels = label2bin(labelnum,labels)

for i = 1 : length(labels)
    if labels(i) == labelnum
        labels(i) = 1;
    else
        labels(i) = 0;
    end
end