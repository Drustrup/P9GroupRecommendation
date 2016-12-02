function result = bordaCount(topK)
returnSize = 10;
movies = unique(topK);
points = zeros(1,numel(movies));
[row,col] = size(topK);
topK = fliplr(topK);

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(topK(i,:)==movies(j)))
           point = point + find(topK(i,:)==movies(j));
       end
    end
    points(j) = point;
end

%result = zeros(1,numel(movies));
%for i=1:numel(movies)
result = zeros(1,returnSize);
for i=1:returnSize
    [M,I] = max(points);
    points(I) = 0;
    result(i) = movies(I);
end
end