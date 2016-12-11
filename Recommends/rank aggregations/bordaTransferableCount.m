function result = bordaCount(topK)
[row,col] = size(topK);
returnSize = col;
movies = unique(topK);
points = zeros(1,numel(movies));
topKMovies = fliplr(topK);
topKVotes = zeros(size(topKMovies));
for i=1:row
    for j=1:col
        topKVotes(i,j)=j;
    end 
end

for j=1:numel(movies)
    point = 0;
    for i=1:row
       if ~isempty(find(topKMovies(i,:)==movies(j)))
           point = point + find(topKMovies(i,:)==movies(j));
       end
    end
    points(j) = point;
end
result=[];
for i=1:numel(points)
    [result, points, movies, topKMovies, topKVotes] = transferVotes(points, movies, topKMovies, topKVotes, result, returnSize);
end
for i=1:numel(points)
    [M,I] = max(points);
    result = [result, movies(I)];
    points(I) = 0;
end
%result = zeros(1,numel(movies));
%for i=1:numel(movies)
%{
while result < 10
    [M,I] = max(points);
    result = [result, movies(I)];
end
%}
end