function [bipar, bipar_dist, munk_neg, munk_neg_dist] = spearman(topK)

[userCount, k] = size(topK); 
 
items = unique(topK); 
n = numel(items);
items = items + n;
topK = topK + n;
W = zeros(n,n);
for j = 1 : n
    c = items(j);
    for z = 1 : n
        count = 0;
        for i = 1 : userCount
            [v,indexC] = find(topK(i,:)==c);
            if ~isempty(indexC)
                W(j,z) = W(j,z) + sqrt((indexC / k - z / n)^2) ; 
                count = count +1;
            end
        end   
        %W(j,z) = W(j,z) / count;
    end
    
end
topK = topK -n;

%When using bipartite_matching
[val, mi, mj]=bipartite_matching(W);
result = zeros(1,n);
for i = 1 : n
    result(mi(i)) = items(mj(i)) - n;
end
result= flip(result); 
result= result; 
temp = zeros(1,k);
for i = 1 : k
    temp(i) = result(i);
end
bipar = temp;
dist = zeros(1,userCount);
for j = 1 : userCount
        dist(j) = kendallDistance(bipar, topK(j,:));
end
bipar_dist = mean(dist);

%When using bipartite_matching reversed W

%{
%W = W * -1 + 3;
[val, mi, mj]=bipartite_matching(W);
result = zeros(1,n);
for i = 1 : n
    result(mj(i)) = items(mi(i)) - n;
end

temp = zeros(1,k);
for i = 1 : k
    temp(i) = result(i);
end
bipar_neg = temp;
dist = zeros(1,userCount);
for j = 1 : userCount
        dist(j) = kendallDistance(bipar_neg, topK(j,:));
end
bipar_neg_dist = mean(dist);

%When using munkres
[mi, mj]=munkres(W);
result = zeros(1,n);
for i = 1 : n
    result(i) = items(mi(i)) - n;
end

result= result; 
temp = zeros(1,k);
for i = 1 : k
    temp(i) = result(i);
end
munk = temp;
dist = zeros(1,userCount);
for j = 1 : userCount
        dist(j) = kendallDistance(munk, topK(j,:));
end
munk_dist = mean(dist);
%}
%negated munkres
W = W * -1;
[mi, mj]=munkres(W);
result = zeros(1,n);
for i = 1 : n
    result(i) = items(mi(i)) - n;
end

result= result; 
temp = zeros(1,k);
for i = 1 : k
    temp(i) = result(i);
end
munk_neg = temp;
dist = zeros(1,userCount);
for j = 1 : userCount
        dist(j) = kendallDistance(munk_neg, topK(j,:));
end
munk_neg_dist = mean(dist);
end