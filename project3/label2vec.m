function  vectors  = label2vec( label )

len = length(label);

A = eye(6);
for i = 1 : len
    switch label(i)
        case 1
            vectors(i,:) = A(1,:);
        case 2
            vectors(i,:) = A(2,:);
        case 3
            vectors(i,:) = A(3,:);
        case 4
            vectors(i,:) = A(4,:);
        case 5
            vectors(i,:) = A(5,:);
        case 6
            vectors(i,:) = A(6,:);
    end
    
end
vectors = transpose(vectors);