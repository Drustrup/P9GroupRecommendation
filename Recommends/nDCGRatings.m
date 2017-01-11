function result = nDCGRatings(ratings, recommendations, users, topKRatings, k)

[rRow,rCol] = size(recommendations);

[row,col] = size(ratings);
userRatings = zeros(numel(users),numel(recommendations));

for i=1:numel(users)
    for j=1:numel(recommendations)
        userRatings(i,j) = ratings(users(i),recommendations(j));
    end
end
%{
[gRow,gCol] = size(group);
topK = ones(gRow,k);
temp = group;
for i=1:gRow
    for j=1:k
        [M,I] = max(temp(i,:));
        topK(i,j)= I;
        temp(i,I) = 0;
    end
end
topK = fliplr(topK);
rankList = zeros(numel(users),rCol);

for i=1:gRow
    for j=1:k
        x = find(recommendations==topK(i,j));
        rankList(i,x) = j;
    end    
end
ideal = sort(1:k, 'descend');
%}
IDCGList = zeros(1, numel(users));
for i=1:numel(users)
    ideal = topKRatings(i,:);
    IDCG = 0;
    for j=1:rCol
        IDCG = IDCG + (ideal(j)/log2(j + 1));
    end
    IDCGList(i) = IDCG;
end

nDCGList = zeros(1,numel(users));
for i=1:numel(users)
    %DCG = rankList(i,1);
    DCG = 0;
    for j=1:rCol
        DCG = DCG + (userRatings(i,j)/log2(j + 1));
    end
    if DCG > 0
        nDCGList(i) = DCG/IDCGList(i);
    else
        nDCGList(i) = DCG;
    end
end
result = nDCGList;
end