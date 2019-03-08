function gain = gain(p, n, p_1, n_1, p_2,n_2)
%This function calculate the gain value used to determine the best
%attribute.
gain = entropy(p,n) - (p_1 + n_1)/(p+n).*entropy(p_1,n_1)- (p_2 + n_2)/(p+n).*entropy(p_2,n_2);