function result = spearman(topK)

[userCount, k] = size(topK); 
 
items = unique(topK); 
n = numel(items);
W = zeros(n,n);
for j = 1 : n
    c = items(j);
    for z = 1 : n
        for i = 1 : userCount
            [v,indexC] = find(topK(i,:)==c);
            if isempty(indexC)
                %If item c is not in a users list we place it at position k + 1
                W(j,z) = W(j,z) + sqrt(((k + 1) / k - z  / k )^2);
            else
                W(j,z) = W(j,z) + sqrt((indexC / k - z / k)^2) ;
            end
        end   
    end
end

%When using bipartite_matching
%{
W = W * -1 + n;
[val, bi, bj]=bipartite_matching(W);
result = zeros(1,n);
for i = 1 : n
	result(bj(i)) = items(i);
end
%result = flip(result);
result = result(1:k);
%}
%Using munkres (Hungarian algorithm) to find the items resulting in lowest
%distance
[x, y] = munkres(W);
result = zeros(1,n);
for i = 1 : n
    result(x(i)) = items(i);
end
result = result(1:k);

end