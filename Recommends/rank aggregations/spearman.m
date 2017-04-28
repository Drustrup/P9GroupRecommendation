function result = spearman(topK)

[userCount, k] = size(topK); 
 
items = unique(topK); 
n = numel(items);
items = items + n;
topK = topK + n;
W = zeros(n,n);
for j = 1 : n
    c = items(j);
    amount = numel(find(topK == c));
    for z = 1 : n
        for i = 1 : userCount
            [v,indexC] = find(topK(i,:)==c);
            if ~isempty(indexC)
                W(j,z) = W(j,z) + sqrt((indexC / k - z / n)^2) ;  
            end
        end   
    end
end
items = items - n;
topK = topK - n;

%When using bipartite_matching
W = W * -1 + n;
[val, bi, bj]=bipartite_matching(W);
result = zeros(1,n);
for i = 1 : n
	result(bj(i)) = items(i);
end
result = result(1:k);

end