function Coefficient = Correlation(input,target)
% calculate the Pearson's(product-moment) correlation coefficient between x and y
% input represnts the input data for one feature, target represents the correspond target data

% select the first attribute of 132 attributes from input data x
% input and output are all 612 * 1 double
%load('emotions_data_66.mat');
%input = x(:,1);
%target = y(:,1);

[m,~] = size(input);
input_ave = sum(input)/m;
target_ave = sum(target)/m;
numerator = 0;
left = 0;
right = 0;
for i = 1: m
    numerator = (input(i) - input_ave)*(target(i) - target_ave) + numerator;
    left = (input(i) - input_ave)^2 + left;
    right = (target(i) - target_ave)^2 + right;
    denominator = left^0.5 * (right^0.5);
end

Coefficient = numerator/ denominator;




