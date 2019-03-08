function entropy = entropy(p,n)
%This function calculate entropy impurity. If any 0 is encountered then the
%term is set to 0.
if n == 0
    entropy = -(p/(p+n)).*log2(p/(p+n));
end
if p == 0
    entropy =  -(n/(p+n)).*log2(n/(p+n));
end
if p==0 && n ==0
    entropy =0;
end
if p~=0 && n~=0
    entropy =  -(p/(p+n)).*log2(p/(p+n)) - (n/(p+n)).*log2(n/(p+n)); 
end