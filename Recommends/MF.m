function [RMSE, predRatings] = MF(data, valData, ratings, valRatings)
usersList = unique(data(:,1));
moviesList = unique(data(:,2));

valUsersList = unique(valData(:,1));
valMoviesList = unique(valData(:,2));

valArray = nonzeros(valRatings);
[valusers, valmovies] = find(valRatings);

lrate = 0.008;
f = 30;
reg = 0.5;
%biasReg = 0.33;
%biasLRate = 0.7;
%Random selected value 
m = 8;
iterations = 50;

A = 3 * rand(f, numel(usersList));
B = 3 * rand(f, numel(moviesList));

[users, movies] = find(ratings);

bItems = zeros(1, numel(moviesList));
bUsers = zeros(1, numel(usersList));
avgRating = sum(nonzeros(ratings))/numel(nonzeros(ratings));


for i=1 : numel(bItems)
   bItem = nonzeros(ratings(:,i));
   if isempty(bItem)
        bItems(i) = 0;
   else 
        bItems(i) = (numel(bItem) * avgRating * m + numel(bItem))/( m * numel(bItem) + numel(bItem));
   end 
end

for i=1 : numel(bUsers)
   bUser = nonzeros(ratings(i,:));
   bUsers(i) = (avgRating * m + sum(bUser))/(m + numel(bUser));
end

for i = 1 : iterations 
    randList = (1:numel(users));
    randList = randList(randperm(length(randList)));
    for z = 1 : numel(users)
       j = randList(z);
       user = users(j);
       movie = movies(j);
       error = ratings(user,movie) -(avgRating + bUsers(user) + bItems(movie) + dot(A(:,user)',B(:,movie)));
       %{
       user_reg = reg / sqrt(numel(ratings(user,:)));
       item_reg = reg / sqrt(numel(ratings(:,movie)));
       %}
       user_reg = reg;
       item_reg = reg;
       tempA = A(:,user);
       A(:,user) = A(:,user) + lrate * (error * B(:,movie) - user_reg * A(:,user));
       B(:,movie) = B(:,movie) + lrate * (error * tempA - item_reg * B(:,movie));
   end   
end
predRatings = A' * B + avgRating;
    
for i = 1 : numel(bUsers)
    for j = 1 : numel(bItems)
      predRatings(i,j) = predRatings(i,j) + bUsers(i) + bItems(j); 
    end
end

predArray = zeros(numel(valArray),1);
for j = 1 : numel(valusers)
    predArray(j) = predRatings(valUsersList(valusers(j)),valMoviesList(valmovies(j)));
end
RMSE = sqrt(immse(valArray ,predArray));
end