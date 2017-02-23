%Find user preferences
function [result, topKRatings] = groupRecommendation(ratings, users,k)
[row,col] = size(ratings);
group = ones(numel(users),col); %Make matrix full of with 1's

%Populates the group matrix with actual ratings
for i=1:numel(users)
    user = ratings(users(i),:);
    group(i,:) = user;
end

%Matrix holding the top k recommendations
[row,col] = size(group);
topK = ones(row,k);         %Holds item ids
topKRatings = ones(row,k);  %Holds item ratings
temp = group;
for i=1:row     %Populate topK and topKRatings matrices
    for j=1:k
        [M,I] = max(temp(i,:));
        topKRatings(i,j) = M;   %Store rating
        topK(i,j)= I;           %Store index
        temp(i,I) = 0;
    end
end

%result = random(topK);
%result = bordaCount(topK);
%result = bordaTransferableCount(topK);
%result = bordaCountWeighted(topK);
%result = bordaCountEscalating(topK);
%result = bordaCountAverage(topK,k,group);  %LEGACY - To be reactivated
result = getTopKTitles(users, topK);
end