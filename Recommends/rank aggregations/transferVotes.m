function [result, points, movies, topKMovies, topKVotes] = transferVotes(points, movies, topKMovies, topKVotes, top, returnSize)
[row,col] = size(topKMovies);

votes = zeros(1,col);
for i=1:col
    votes(i) = i;
end
threshold = sum(votes) * row;
threshold = threshold / returnSize;

[vMax,iMax] = max(points);
movie = movies(iMax);
userVotes = [];
users = [];
if  vMax >= threshold
   top(numel(top) + 1) = movies(iMax);
   transfer = points(iMax) - threshold;
   for j=1:row
       vote = find(topKMovies(j,:)==movies(iMax));
       if ~isempty(vote)
           userVotes = [userVotes, vote];
           users = [users, j];
           topKMovies(j,vote) = NaN;
           topKVotes(j,vote) = NaN;
       end
   end
   points(iMax) = [];
   movies(iMax) = [];
   
   for i=1:numel(users)
   highMovie = 0;
   index = [];
   voteIndex = [];
   for z=1:col
       tempMovie=points(find(movies==topKMovies(users(i),z)));
       if tempMovie > highMovie
           highMovie = tempMovie;
           index = find(movies==topKMovies(users(i),z));
           voteIndex = z;
       end
   end
end
points(index) = points(index) + transfer * (userVotes(i)/sum(userVotes));
topKVotes(users(i),voteIndex) = topKVotes(users(i),voteIndex) + transfer * (userVotes(i)/sum(userVotes));
   
elseif numel(top)+numel(points) > returnSize
   [transfer, index] = min(points);
   for j=1:row
       vote = find(topKMovies(j,:)==movies(index));
       if ~isempty(vote)
           userVotes = [userVotes, vote];
           users = [users, j];
           topKVotes(j,vote) = NaN;
           topKMovies(j,vote) = NaN;
       end
   end
   points(index) = [];
   movies(index) = [];
   for i=1:numel(users)
   highMovie = 0;
   index = [];
   voteIndex = [];
   for z=1:col
       tempMovie=points(find(movies==topKMovies(users(i),z)));
       if tempMovie > highMovie
           highMovie = tempMovie;
           index = find(movies==topKMovies(users(i),z));
           voteIndex = z;
       end
   end
end
points(index) = points(index) + transfer * (userVotes(i)/sum(userVotes));
topKVotes(users(i),voteIndex) = topKVotes(users(i),voteIndex) + transfer * (userVotes(i)/sum(userVotes));
end

       
result = top;
end