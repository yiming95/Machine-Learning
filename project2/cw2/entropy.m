function entropy = entropy(p,n)
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