clear all;
ratings = importdata('../dataset/movielens/u2_base_matrix.txt');
baseMovies = importdata('../dataset/movielens/u2_base_different_movies.txt');
baseUsers = importdata('../dataset/movielens/u2_base_different_users.txt');
k = 10;
A = ones(numel(baseUsers),k);
B = ones(k,numel(baseMovies));
lowA = A;
lowB = B;

valUsers = importdata('../dataset/movielens/u2_test_different_users.txt');
valMovie = importdata('../dataset/movielens/u2_test_different_movies.txt');
val = importdata('../dataset/movielens/u2_test_matrix.txt');

totalRatings = importdata('../dataset/movielens/u_matrix.txt');

validationArray = nonzeros(val);
[row, col] = find(val);

reg = 0.01;
learn = 0.005;

[rows, cols] = find(ratings);
rmse = k;
pRmse = k + 1;
lowRmse = 10;
threshold = 0;
while threshold < 3000000 && rmse < pRmse
    x = randi([1 80000], 1,1);
    
    vectorA = A(rows(x),:);
    vectorB = B(:,cols(x));
    error = ratings(rows(x),cols(x)) - sum(vectorA * vectorB);
   
     for i=1:numel(vectorA)
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
        valPred = ones(numel(valUsers),numel(baseMovies));
        predictionArray = ones(numel(col),1);

        for i=1:numel(valUsers)
            valPred(i,:) = predRatings(valUsers(i),:);
        end

        for i=1:numel(col)
            predictionArray(i) = valPred(row(i), valMovie(col(i)));
        end
   
        rmse = sqrt(immse(validationArray, predictionArray)); 
    end
    
   threshold = threshold + 1;  
end
%{
predRatings = A * B;
valUsers = importdata('../dataset/movielens/u1_test_different_users.txt');
valMovie = importdata('../dataset/movielens/u1_test_different_movies.txt');
validation = importdata('../dataset/movielens/u1_test_matrix.txt');

totalRatings = importdata('../dataset/movielens/u_matrix.txt');
totalUsers = importdata('../dataset/movielens/u_different_users.txt');
totalMovie = importdata('../dataset/movielens/u_different_movies.txt');


validationArray = nonzeros(validation);
[rows, cols] = find(validation);

valTotal = [];
valPred = [];
predictionArray = [];
totalArray = [];

for i=1:numel(valUsers)
    valPred = [valPred;predRatings(valUsers(i),:)];
    valTotal = [valTotal;totalRatings(valUsers(i),:)];
end

j = 1;
for i=1:numel(cols)
    totalArray = [totalArray;valTotal(rows(i), valMovie(cols(i)))];
    predictionArray = [predictionArray;valPred(rows(i), valMovie(cols(i)))];
    
end
   
%{
fid1 = fopen('prediction.txt','wt');
fid = fopen('validationNew.txt','wt');
fprintf(fid,'%f\n',validationArray);
fprintf(fid1,'%f\n',predictionArray);
fclose(fid);
fclose(fid1);
%}
rmse = sqrt(immse(validationArray, predictionArray)); 
trmse = sqrt(immse(validationArray, totalArray));
%}