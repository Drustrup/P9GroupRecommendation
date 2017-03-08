function [result] = average(ratings, users, topK)
items = sort(unique(topK),'ascend');
avgList = zeros(numel(items),1);
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
result = zeros(k,1);
for i = 1 : k
    [V,I] = max(avgList);
    result(i) = items(I);
    avgList(I) = [];
end
result = result';
end