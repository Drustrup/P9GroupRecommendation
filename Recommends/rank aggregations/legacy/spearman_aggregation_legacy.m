function [bipar, bipar_dist, munk, munk_dist] = spearman_aggregation(topK)

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
bipar= flip(result);
%bipar= result; 
dist = zeros(1,userCount);
for j = 1 : userCount
        dist(j) = kendallDistance(bipar, topK(j,:));
end
bipar_dist = mean(dist);
%When using bipartite_matching reversed W

%{
%W = W * -1 + 3;
[val, mi, mj]=bipartite_matching(W);
result = zeros(1,k);
for i = 1 : k
    result(mj(i)) = items(mi(i)) - n;
end
bipar_neg= result; 
%}
%When using munkres
%W = W * -1;
[mi, mj]=munkres(W);
result = zeros(1,k);
for i = 1 : k
    result(i) = items(mi(i));
end
munk= result;

dist = zeros(1,userCount);
for j = 1 : userCount
    dist(j) = kendallDistance(munk, topK(j,:));
end
munk_dist = mean(dist);
end