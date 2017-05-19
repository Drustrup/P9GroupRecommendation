function [result] = average(ratings, users, topK)
items = sort(unique(topK),'ascend');
avgList = zeros(1,numel(items));
[row,k] = size(topK);
count = 1;
while count <= numel(items)
    avg = 0;
    for i = 1 : numel(users)
        avg = avg + ratings(users(i),items(count));
    end
    avgList(count) = avg/numel(users);
    count = count + 1;
end
result = zeros(1,k);
for i = 1 : k
    [V,I] = max(avgList);
    result(i) = items(I);
    avgList(I) = [];
    items(I) = [];
end
%result = result';
end