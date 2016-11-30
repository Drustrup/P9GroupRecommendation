function result = bordaCount(lists)
movies = unique(lists);
points = zeros(1,numel(movies));
[row,col] = size(lists);
lists = fliplr(lists);

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(lists(i,:)==movies(j)))
           point = point + find(lists(i,:)==movies(j));
       end
    end
    points(j) = point;
end

result = zeros(1,numel(movies));
for i=1:numel(movies)
    [M,I] = max(points);
    points(I) = 0;
    result(i) = movies(I);
end
end