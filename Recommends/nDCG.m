function result = nDCG(ratings, recommendations, users, k)

[rRow,rCol] = size(recommendations);

[row,col] = size(ratings);
group = ones(numel(users),col);

for i=1:numel(users)
    user = ratings(users(i),:);
    group(i,:) = user;
end

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
IDCGList = zeros(1, numel(users));
for i=1:numel(users)
    ideal = sort(rankList(i,:), 'descend');
    IDCG = ideal(1);
    for j=2:rCol
        IDCG = IDCG + (ideal(j)/log2(j));
    end
    IDCGList(i) = IDCG;
end

nDCGList = zeros(1,numel(users));
for i=1:numel(users)
    DCG = rankList(i,1);
    for j=2:rCol
        DCG = DCG + (rankList(i,j)/log2(j));
    end
    if DCG > 0
        nDCGList(i) = DCG/IDCGList(i);
    else
        nDCGList(i) = DCG;
    end
end
result = nDCGList;
end