%Funk SVD
clear all;
ratings = importdata('../dataset/movielens/u_matrix.txt');
movies = importdata('../dataset/movielens/u_different_movies.txt');
users = importdata('../dataset/movielens/u_different_users.txt');

k = 20;
reg = 0.3;
learn = 0.1;

A = ones(numel(users),k);
B = ones(k,numel(movies));
A = A / 10;
B = B /10;
%{
A = rand(numel(users),k);
B = rand(k,numel(movies));

valUsers = importdata('../dataset/movielens/u2_test_different_users.txt');
valMovies = importdata('../dataset/movielens/u2_test_different_movies.txt');
val = importdata('../dataset/movielens/u2_test_matrix.txt');

%totalRatings = importdata('../dataset/movielens/u_matrix.txt');
5
%}

valUsers = importdata('../dataset/movielens/u_different_users.txt');
valMovies = importdata('../dataset/movielens/u_different_movies.txt');
val = importdata('../dataset/movielens/u_matrix.txt');

validationArray = nonzeros(val);
[row, col] = find(val);

[rows, cols] = find(ratings);

%{
rmse = k;
pRmse = k + 1;
lowRmse = 10;
lowA = A;
lowB = B;
%}

bItems = zeros(1, numel(movies));
bUsers = zeros(1, numel(users));
avgRating = sum(validationArray)/numel(validationArray);

for i=1 : numel(bItems)
   bItem = nonzeros(ratings(:,i));
   if isempty(bItem)
        bItems(i) = 0;
   else 
        bItems(i) = (sum(bItem)/numel(bItem)) - avgRating;
   end 
end

for i=1 : numel(bUsers)
   bUser = nonzeros(ratings(i,:));
   bUsers(i) = (sum(bUser)/numel(bUser)) - avgRating;
end

threshold = 0;

while threshold < 1
    %{
    randList = (1:numel(rows));
    randList = randList(randperm(length(randList)));
    %}
    for j = 1 : k
        %x = randList(y);
        for x = 1: numel(rows)
        vectorA = A(rows(x),:);
        vectorB = B(:,cols(x));
            %error = ratings(rows(x),cols(x)) -(avgRating + bUsers(rows(x)) + bItems(cols(x)) + dot(vectorA,vectorB));
            error = ratings(rows(x),cols(x)) - dot(vectorA, vectorB);
            errorThreshold = error + 1;
            breakTreshold = 0;
            while errorThreshold > error && breakTreshold < 100
                errorThreshold = error;
                tempA =  vectorA(j);
                vectorA(j) = vectorA(j) + learn * (error * vectorB(j) - reg * ( vectorA(j)));
                vectorB(j) = vectorB(j) + learn * (error * tempA - reg *  (vectorB(j)));

                %error = ratings(rows(x),cols(x)) -(avgRating + bUsers(rows(x)) + bItems(cols(x)) + dot(vectorA, vectorB));
                error = ratings(rows(x),cols(x)) - dot(vectorA, vectorB);
                breakTreshold = breakTreshold + 1;
            end
        A(rows(x),:) = vectorA;
        B(:,cols(x)) = vectorB;
        end
         %{
        if mod(threshold, 10) == 0 
            if rmse < lowRmse
                lowRmse = rmse;
                pRmse = rmse + 0.1;
                lowA = A;
                lowB = B;
            end
            predRatings = A * B + avgRating;
            for i = 1 : numel(users)
               for j = 1 : numel(movies)
                  predRatings(i,j) = predRatings(i,j) + bUsers(i) + bItems(j); 
               end            
            end
            predictionArray = ones(numel(col),1);

            for i=1:numel(col)
                %[valM,valI] = find(movies == valMovies(col(i)));
                %[valU,valV] = find(users == valUsers(row(i)));
                predictionArray(i) = predRatings(valUsers(row(i)),valMovies(col(i)));
            end
            rmse = sqrt(immse(validationArray, predictionArray));
        end
         %}

    end
    
    threshold = threshold + 1;  
end
  %{  
    predRatings = A * B + avgRating;
    for i = 1 : numel(users)
       for j = 1 : numel(movies)
          predRatings(i,j) = predRatings(i,j) + bUsers(i) + bItems(j); 
       end            
    end
    predictionArray = ones(numel(col),1);

    for i=1:numel(col)
        %[valM,valI] = find(movies == valMovies(col(i)));
        %[valU,valV] = find(users == valUsers(row(i)));
        predictionArray(i) = predRatings(valUsers(row(i)),valMovies(col(i)));
    end
    rmse = sqrt(immse(validationArray, predictionArray));
    %%%%%%
      %}
    predRatings = A * B;

    predictionArray = ones(numel(col),1);

    for i=1:numel(col)
        predictionArray(i) = predRatings(valUsers(row(i)),valMovies(col(i)));
    end
    rmse = sqrt(immse(validationArray, predictionArray));
    
  

%{
dlmwrite('myFile.txt',M,'delimiter','\t','precision',3)
fid1 = fopen('prediction.txt','wt');
fid = fopen('validationNew.txt','wt');
fprintf(fid,'%f\n',validationArray);
fprintf(fid1,'%f\n',predictionArray);
fclose(fid);
fclose(fid1);
%}