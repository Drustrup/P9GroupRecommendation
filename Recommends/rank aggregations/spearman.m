function result = spearman(topK)

[userCount, k] = size(topK); 
 
items = unique(topK); 
n = numel(items);
items = items + n;
topK = topK + n;
W = zeros(n,n);
for j = 1 : n
    c = items(j);
    for z = 1 : k
        for i = 1 : userCount
            [v,indexC] = find(topK(i,:)==c);
            if ~isempty(indexC)
                W(j,z) = W(j,z) + sqrt((indexC / k - z / k)^2); 
            end
        end   
    end
end
items = items - n;
topK = topK - n;
%When using bipartite_matching
[val, bi, bj]=bipartite_matching(W);
result = zeros(1,k);
for i = 1 : k
	result(bj(i)) = items(bi(i));
end
result= flip(result);

end