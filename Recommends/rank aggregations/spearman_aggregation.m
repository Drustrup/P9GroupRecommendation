function [result] = spearman_aggregation(topK)

[userCount, k] = size(topK); 
 
items = unique(topK); 
n = numel(items);
items = items + n;
topK = topK + n;
W = zeros(n,k);
for j = 1 : n
    c = items(j);
    for z = 1 : k
        for i = 1 : userCount
            [v,indexC] = find(topK(i,:)==c);
            if ~isnan(indexC)
                W(j,z) = W(j,z) + sqrt((indexC / k - z / k)^2) ; 
            %else
             %   W(j,z) = W(j,z) + sqrt((k + 1 / k - z / k)^2) ;
            end
        end   
    end
end
%W = W / userCount;
%W = (W * -1) + 3;   

%When using bipartite_matching

[val, mi, mj]=bipartite_matching(W);
result = zeros(1,k);
for i = 1 : k
    result(mj(i)) = items(mi(i)) - n;
end
result= flip(result); 

%When using bipartite_matching reversed W
%{
W = W * -1 + 3;
[val, mi, mj]=bipartite_matching(W);
result = zeros(1,k);
for i = 1 : k
    result(mj(i)) = items(mi(i)) - n;
end
result= result; 
%}
%When using munkres
%{
W = W * -1;
[mi, mj]=munkres(W);
result = zeros(1,k);
for i = 1 : k
    result(i) = items(mi(i)) - n;
end
result= result; 
%}
end