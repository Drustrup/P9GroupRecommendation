function result = bordaCountEscalating(topK)
[row,col] = size(topK);
k = col;
movies = unique(topK);
points = zeros(1,numel(movies));
topK = fliplr(topK);
%Thresholds for what they get in bonus
bot = floor(k/3);
middle = bot + ceil(k/3);

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(topK(i,:)==movies(j)))
           [R,C] = find(topK(i,:)==movies(j));
           point = point + find(topK(i,:)==movies(j));
           if C > middle    %If index above middle threshold
               point = point + 3;
           elseif C > bot && C < middle %Above bottom and below high
               point = point + 1;
           end
       end
    end
    points(j) = point;
end

result = zeros(1,k);
for i=1:k
    [M,I] = max(points);
    points(I) = 0;
    result(i) = movies(I);
end
end