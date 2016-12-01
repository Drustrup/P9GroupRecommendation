function result = bordaCountAverage(topK, k, group)
[row,col] = size(topK);
temp = ones(row,k);

for i=1:row
   for j=1:col
       temp(i,j) = mean(group(:,topK(i,j)));
   end
end
topKAvg = zeros(row,col);
for i=1:row
    for j=1:col
        [M,I] = max(temp(i,:));
        temp(i,I) = 0;
        topKAvg(i,j) = topK(i,I);
    end
end
result = bordaCount(topKAvg);
end