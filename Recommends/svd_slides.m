clear all;
ratings = importdata('../dataset/movielens/u1_base_matrix.txt');
[U, S, V] = svds(ratings, 10);
A = U * S^0.5;
B = S^0.5 * transpose(V);
clear U S V;

reg = 0.01;
learn = 0.01;

[rows, cols] = find(ratings);
treshold = 0;
while treshold < 0
    
    x = randi([1 80000], 1,1);
    
    vectorA = A(rows(x),:);
    vectorB = B(:,cols(x));
    error = sqrt((ratings(rows(x),cols(x)) - sum(vectorA * vectorB)) .^2)^2 + reg * (sqrt(sum(vectorA .^2))^2 + sqrt(sum(vectorB .^2))^2);
    %error = ratings(rows(x),cols(x)) - sum(vectorA * vectorB);
    for i=1:numel(vectorA)
        tempA = A(rows(x),i);
        A(rows(x),i) = A(rows(x),i) + learn * error * B(i,cols(x)) - reg * A(rows(x),i) ;
        B(i,cols(x)) =  B(i,cols(x)) + learn * tempA * error - reg * B(i,cols(x)) ;      
    end 
    
   treshold = treshold + 1;  
end

predRatings = A * B;
baseMovie = importdata('../dataset/movielens/u1_base_different_movies.txt');
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
k = 1;
for i=1:numel(cols)
    
    %{
    for j = 1 : numel(baseMovie)
      	if baseMovie(j) == valMovie(cols(i))
         	predictionArray = [predictionArray;valPred(rows(i), j)];
        end
    end
   	for j = 1 : numel(totalMovie)
      	if totalMovie(j) == valMovie(cols(i))
         	totalArray = [totalArray;totalRatings(rows(i), j)];
        end
    end
    %}
    while totalMovie(j) ~= valMovie(cols(i)) && j < numel(totalMovie)
        j = j + 1;
    end
    if totalMovie(j) == valMovie(cols(i))
      	totalArray = [totalArray;valTotal(rows(i), j)];
    end
    
    while baseMovie(k) ~= valMovie(cols(i)) && k < numel(baseMovie)
        k = k + 1;
    end
    if baseMovie(k) == valMovie(cols(i))
      	predictionArray = [predictionArray;valPred(rows(i), k)];
   	end
    
end
   
%{
fid1 = fopen('prediction.txt','wt');
fid = fopen('validationNew.txt','wt');
fprintf(fid,'%f\n',validationArray);
fprintf(fid1,'%f\n',predictionArray);
fclose(fid);
fclose(fid1);
%}
%rmse = sqrt(immse(validationArray, predictionArray)); 
trmse = sqrt(immse(validationArray, totalArray));
