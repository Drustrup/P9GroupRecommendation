function result = random(topK)
[row,col] = size(topK);
returnSize = col;
movies = unique(topK);
index = randperm(numel(movies),returnSize); 
result = zeros(1, returnSize);
for i=1:returnSize
    result(i) = movies(index(i));
end
end