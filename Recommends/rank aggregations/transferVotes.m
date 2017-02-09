function [result, points, movies, resultKMovies, resultKVotes] = transferVotes(points, movies, resultKMovies, resultKVotes, result, k)
[row,col] = size(resultKMovies);

votes = 1:col;
threshold = sum(votes) * row;
threshold = threshold / k;

[vMax,iMax] = max(points);
movie = movies(iMax);
userVotes = [];
users = [];
if  vMax >= threshold %If a position is guaranteed
   result(numel(result) + 1) = movies(iMax);
   transfer = points(iMax) - threshold;
   for j=1:row
       vote = find(resultKMovies(j,:)==movies(iMax));
       if ~isempty(vote)
           userVotes = [userVotes, vote];
           users = [users, j];
           resultKMovies(j,vote) = NaN;
           resultKVotes(j,vote) = NaN;
       end
   end
   points(iMax) = [];
   movies(iMax) = [];
   %Redistribute extra points
      for i=1:numel(users)
       [M,I] = max(resultKVotes(users(i),:));
       movieIndex = find(movies == resultKMovies(users(i),I));
       points(movieIndex) = points(movieIndex) + transfer * (userVotes(i)/sum(userVotes));
       resultKVotes(users(i),I) = resultKVotes(users(i),I) + transfer * (userVotes(i)/sum(userVotes));
      end
%If no winner, remove loser with least votes
elseif numel(result)+numel(points) > k
   [transfer, index] = min(points);
   for j=1:row
       vote = find(resultKMovies(j,:)==movies(index));
       if ~isempty(vote)
           userVotes = [userVotes, vote];
           users = [users, j];
           resultKVotes(j,vote) = NaN;
           resultKMovies(j,vote) = NaN;
       end
   end
   points(index) = [];
   movies(index) = [];
   %Redistribute extra points
   for i=1:numel(users)
       [M,I] = max(resultKVotes(users(i),:));
       movieIndex = find(movies == resultKMovies(users(i),I));
       points(movieIndex) = points(movieIndex) + transfer * (userVotes(i)/sum(userVotes));
       resultKVotes(users(i),I) = resultKVotes(users(i),I) + transfer * (userVotes(i)/sum(userVotes));
    end
end
end