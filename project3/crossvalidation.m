function indices = crossvalidation(n,examples)
%n is number of fold, examples is just the number of examples.
%This function devide examples into n groups.
reminder = rem(examples,n);
k = round(examples/n);
for i = 1 : k
    j = (i-1)*k + 1;
    o = i * k;
    groups(j:o) = i;
end

for i = 1 : reminder
    groups(n * k + i) = randi(n);
end
shuffle = randperm(examples);

for i = 1 : examples
    indices(i) = groups(shuffle(i));
end