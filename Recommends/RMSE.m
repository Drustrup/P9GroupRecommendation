val = importdata('../dataset/u_matrix.txt');
valMovies = importdata('../dataset/movielens/u_different_movies.txt');
valUsers = importdata('../dataset/movielens/u_different_users.txt');

validationArray = nonzeros(val);
[row, col] = find(val);

predictionArray = ones(numel(col),1);
predRatings = lowA*lowB;
for i=1:numel(col)
    predictionArray(i) = predRatings(valUsers(row(i)),valMovies(col(i)));
end

rmse = sqrt(immse(validationArray, predictionArray));