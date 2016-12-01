%Find user preferences
function result = groupRecommendation(users,k)
ratings = importdata('../dataset/trained_matrix.txt');
[row,col] = size(ratings);
group = ones(numel(users),col);

for i=1:numel(users)
    user = ratings(users(i),:);
    group(i,:) = user;
end

[row,col] = size(group);
topK = ones(row,k);
temp = group;
for i=1:row
    for j=1:k
        [M,I] = max(temp(i,:));
        topK(i,j)= I;
        temp(i,I) = 0;
    end
end
result = bordaCount(topK);
%result = bordaCountAverage(topK,k,group);
%result = bordaCountWeighted(topK);
%result = bordaCountEscalating(topK,k);
end