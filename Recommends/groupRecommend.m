%Find user preferences
function result = groupRecommendation(list,k)
ratings = importdata('../dataset/trained_matrix.txt');
[row,col] = size(ratings);
group = ones(numel(list),col);
for i=1:numel(list)
    user = ratings(list(i),:);
    group(i,:) = user;
end
%Average aggregation
result = average(group,k);
end