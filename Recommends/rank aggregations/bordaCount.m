%Disclaimer: Does not follow standard borda count. Does not handle movies
%with equal ratings, which should have the same score.

function result = bordaCount(topK)
[row,col] = size(topK);
k = col;    %Return size
movies = unique(topK);
points = zeros(1,numel(movies));    %1-by-unique-movies matrix
topK = fliplr(topK);        %Flips topk on its head, smallest first

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(topK(i,:)==movies(j)))  %If movie is in users' topK
           point = point + find(topK(i,:)==movies(j));  %Sum the points for each such user
       end
    end
    points(j) = point;  %Store in list of points for a movie
end

%Instantiate result matrix and find k biggest scores
result = zeros(1,k);
for i=1:k
    [M,I] = max(points);
    points(I) = 0;
    result(i) = movies(I);
end
end