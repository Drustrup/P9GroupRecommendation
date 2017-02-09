function result = bordaCountWeighted(topK)
[row,col] = size(topK);
k = col;
movies = unique(topK);
points = zeros(1,numel(movies));     %1-by-unique-movies matrix
topK = fliplr(topK);            %Flips topk on its head, smallest first
topKFlat = topK(:);             %Transforms matrix to an array

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(topK(i,:)==movies(j)))
           point = point + find(topK(i,:)==movies(j));
       end
    end
    point = point + sum(topKFlat==movies(j));   %Add val based on nr of entries
    points(j) = point;
end

result = zeros(1,k);
for i=1:k
    [M,I] = max(points);
    points(I) = 0;
    result(i) = movies(I);
end
end