function result = bordaCountEscalating(topK)
[row,col] = size(topK);
k = col;
returnSize = col;
movies = unique(topK);
points = zeros(1,numel(movies));
topK = fliplr(topK);
top = floor(k/3);
middle = top + ceil(k/3);

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(topK(i,:)==movies(j)))
           point = point + find(topK(i,:)==movies(j));
           if i <= top
               point = point + 3;
           elseif i > top && i <= middle
               point = point + 1;
           end  
       end
    end
    points(j) = point;
end

result = zeros(returnSize);
for i=1:returnSize
    [M,I] = max(points);
    points(I) = 0;
    result(i) = movies(I);
end
end