function [result] = spearman(topK)

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
%[val, mi, mj]=bipartite_matching(W);
[mi, mj]=munkres(W);

result = zeros(1,k);
for i = 1 : k
    %result(i) = items(mj(i)) - n;
    result(i) = items(mi(i)) - n;
end

end