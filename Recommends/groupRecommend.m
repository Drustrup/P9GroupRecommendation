%Find user preferences
function result = groupRecommendation(list)
ratings = importdata('../dataset/test.txt');
[row,col] = size(ratings);
group = ones(numel(list),col);
for i=1:numel(list)
    user = ratings(list(i),:);
    group(i,:) = user;
end
result = average(group);
end