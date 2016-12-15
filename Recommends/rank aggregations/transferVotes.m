function [result, points, movies, topKMovies, topKVotes] = transferVotes(points, movies, topKMovies, topKVotes, top, returnSize)
[row,col] = size(topKMovies);

votes = 1:col;
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
       [M,I] = max(topKVotes(users(i),:));
       movieIndex = find(movies == topKMovies(users(i),I));
       points(movieIndex) = points(movieIndex) + transfer * (userVotes(i)/sum(userVotes));
       topKVotes(users(i),I) = topKVotes(users(i),I) + transfer * (userVotes(i)/sum(userVotes));
    end
       
   
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
       [M,I] = max(topKVotes(users(i),:));
       movieIndex = find(movies == topKMovies(users(i),I));
       points(movieIndex) = points(movieIndex) + transfer * (userVotes(i)/sum(userVotes));
       topKVotes(users(i),I) = topKVotes(users(i),I) + transfer * (userVotes(i)/sum(userVotes));
    end
end

       
result = top;
end