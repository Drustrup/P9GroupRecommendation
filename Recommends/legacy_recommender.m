clear all;
learn = 0.025;
reg = 0.2;
%ratings = importdata('../dataset/random/matrix.txt');
ratings = importdata('../dataset/movielens/u1_base_matrix.txt');

%Constructing A and B matrix.
[userV, v, trackV] = svds(ratings,85);
A = userV * v^0.5;
B = v^0.5 * transpose(trackV);

%Learning
[rows, cols] = find(ratings);
threshold = 0;
while threshold < 0
    
    x = randi([1 80000], 1,1);
        
        %Calculating the error in the prediction. 
    vectorA = A(rows(x),:);
    vectorB = B(:,cols(x));
    error = ratings(rows(x),cols(x)) - sum(vectorA * vectorB);
        %regError = (ratings(row,col) - sum(vectorA * vectorB))^2 + reg * (sum(vectorA)^2 + sum(vectorB)^2);
        %regError = sqrt((ratings(rows(x),cols(x)) - sum(vectorA * vectorB)).^2)^2 + reg * (sqrt(sum(vectorA .^2))^2 + sqrt(sum(vectorB .^2)))^2;
        
        for i=1:numel(vectorA)
        tempA = A(rows(x),i);
           A(rows(x),i) = A(rows(x),i) + learn * (error * B(i,cols(x)) - reg * A(rows(x),i));
           B(i,cols(x)) = B(i,cols(x)) + learn * (error * tempA - reg * B(i,cols(x)));
        end

        %{ 

        %This kinda works
        
        
        %From slides       

        
    for i=1:numel(vectorA)
        tempA = A(rows(x),i);
        A(rows(x),i) = A(rows(x),i) + learn * error * B(i,cols(x)) ;
        B(i,cols(x)) =  B(i,cols(x)) + learn * tempA * error ;      
    end 
        %}
        threshold = threshold + 1;
end

%Validation
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

valTotal = ones(numel(valUsers),numel(totalMovie));
valPred = ones(numel(valUsers),numel(baseMovie));
predictionArray = ones(numel(cols),1);
totalArray = ones(numel(cols),1);

for i=1:numel(valUsers)
    valPred(i,:) = predRatings(valUsers(i),:);
    valTotal(i,:) = totalRatings(valUsers(i),:);
end

for i=1:numel(cols)
    j = find(cols(i)==totalMovie);
    totalArray(i) = valTotal(rows(i), valMovie(j));
    
    k = find(cols(i)==baseMovie);
    if isempty(k)
        validationArray(i) = 0;
        totalArray(i) = 0;
        predictionArray(i) = 0;
    else
        predictionArray(i) = valPred(rows(i), valMovie(k));
    end
    %{
    while totalMovie(j) ~= valMovie(cols(i)) && j < numel(totalMovie)
        j = j + 1;
    end
    if totalMovie(j) == valMovie(cols(i))
      	totalArray(i) = valTotal(rows(i), j);
    end
    for k = 1 : numel(totalMovie)
                if totalMovie(k) == valMovie(cols(i))
                    totalArray(i) = valTotal(rows(i), k);
                end
    end
    for k = 1 : numel(baseMovie)
                if baseMovie(k) == valMovie(cols(i))
                    predictionArray(i) = valPred(rows(i), k);
                end
    end
    
    %}
    
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