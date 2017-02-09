%Funk SVD
clear all;
ratings = importdata('../dataset/movielens/u_matrix.txt');
movies = importdata('../dataset/movielens/u_different_movies.txt');
users = importdata('../dataset/movielens/u_different_users.txt');
k = 20;

A = ones(numel(users),k)/10;
B = ones(k,numel(movies))/10;

lowA = A;
lowB = B;
%{
valUsers = importdata('../dataset/movielens/u1_test_different_users.txt');
valMovies = importdata('../dataset/movielens/u1_test_different_movies.txt');
val = importdata('../dataset/movielens/u1_test_matrix.txt');
%}

valUsers = importdata('../dataset/movielens/u_different_users.txt');
valMovies = importdata('../dataset/movielens/u_different_movies.txt');
val = importdata('../dataset/movielens/u_matrix.txt');
%totalRatings = importdata('../dataset/movielens/u_matrix.txt');

validationArray = nonzeros(val);
[row, col] = find(val);

reg = 0.5;
learn = 0.01;

[rows, cols] = find(ratings);
rmse = k;
pRmse = k + 1;
lowRmse = 10;
threshold = 0;

while threshold < 1000000 && rmse < pRmse
    x = randi([1 numel(rows)], 1,1);
    
    vectorA = A(rows(x),:);
    vectorB = B(:,cols(x));
    error = ratings(rows(x),cols(x)) - dot(vectorA, vectorB);
    
     for i=1:k
        tempA = A(rows(x),i);
        A(rows(x),i) = A(rows(x),i) + learn * (error * B(i,cols(x)) - reg * A(rows(x),i));
        B(i,cols(x)) = B(i,cols(x)) + learn * (error * tempA - reg * B(i,cols(x)));
     end
    if mod(threshold, 1000) == 0 
        if rmse < lowRmse
            lowRmse = rmse;
            pRmse = rmse + 0.1;
            lowA = A;
            lowB = B;
        end
        predRatings = A * B;
        predictionArray = ones(numel(col),1);
        
        for i=1:numel(col)
            %[valM,valI] = find(movies == valMovies(col(i)));
            %[valU,valV] = find(users == valUsers(row(i)));
            predictionArray(i) = predRatings(valUsers(row(i)),valMovies(col(i)));
        end
        rmse = sqrt(immse(validationArray, predictionArray));
    end
    
   threshold = threshold + 1;  
end

%{
fid1 = fopen('prediction.txt','wt');
fid = fopen('validationNew.txt','wt');
fprintf(fid,'%f\n',validationArray);
fprintf(fid1,'%f\n',predictionArray);
fclose(fid);
fclose(fid1);
%}