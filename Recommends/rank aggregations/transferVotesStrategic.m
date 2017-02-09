 function [result, points, movies, resultKMovies, resultKVotes] = transferVotesStrategic(points, movies, resultKMovies, resultKVotes, result, k)
[row,col] = size(resultKMovies);

votes = 1:col;
threshold = sum(votes) * row;
threshold = threshold / k;

[vMax,iMax] = max(points);
movie = movies(iMax);   %Movie with most points - iMax -> index of movie
userVotes = [];
users = [];
if  vMax >= threshold
   result(numel(result) + 1) = movies(iMax);  %Increase size of result by 1 to fit new item
   transfer = points(iMax) - threshold;     %Remove extra points
   for j=1:row
       %Find all users who voted on the movie and null their votes
       vote = find(resultKMovies(j,:)==movies(iMax));
       if ~isempty(vote)
           userVotes = [userVotes, vote];
           users = [users, j];
           resultKMovies(j,vote) = NaN;
           resultKVotes(j,vote) = NaN;
       end
   end
   points(iMax) = [];   %Null movie to avoid it later
   movies(iMax) = [];
   
   %Reassign votes to highest on their favorite points list
   for i=1:numel(users)
   highMovieScore = 0;
   index = [];
   voteIndex = [];
       for z=1:col
           tempMovieScore=points(find(movies==resultKMovies(users(i),z)));
           if tempMovieScore > highMovieScore
               highMovieScore = tempMovieScore;
               index = find(movies==resultKMovies(users(i),z));
               voteIndex = z;
           end
       end
       %Transfer percentage of votes based on total votes on original item
       points(index) = points(index) + transfer * (userVotes(i)/sum(userVotes));
       %Update individual votes for users
       resultKVotes(users(i),voteIndex) = resultKVotes(users(i),voteIndex) + transfer * (userVotes(i)/sum(userVotes));
    end
   
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
   for i=1:numel(users)
   highMovieScore = 0;
   index = [];
   voteIndex = [];
       for z=1:col
           tempMovieScore=points(find(movies==resultKMovies(users(i),z)));
           if tempMovieScore > highMovieScore
               highMovieScore = tempMovieScore;
               index = find(movies==resultKMovies(users(i),z));
               voteIndex = z;
           end
       end
       
       points(index) = points(index) + transfer * (userVotes(i)/sum(userVotes));
       resultKVotes(users(i),voteIndex) = resultKVotes(users(i),voteIndex) + transfer * (userVotes(i)/sum(userVotes));
    end
end
end