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

for i=1:(numel(points)- returnSize)
    [M,iLow] = min(points);
    lovMovie = movies(iLow);
    for j=1:row
        if ~isempty(find(topK(j,:)==lovMovie))
            highMovie = 0;
            count = 0;
            while highMovie == 0 && count < col
                [M,iHigh] = max(points);
                tempMovie = movies(iHigh);
                if ~isempty(find(topK(j,:)==tempMovie))
                    highMovie = tempMovie;
                end
                count = count + 1;
            end
            points(iHigh) = points(iHigh) + points(iLow);
            points(iLow) = [];
            movies(iLow) = [];
        end
    end
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