clear all;
learn = 0.001;
reg = 0.5;
temp = 0;
%ratings = importdata('../dataset/random/matrix.txt');
ratings = importdata('../dataset/test.txt');
ratingsS = sparse(ratings);

%Constructing A and B matrix.
[userV, v, trackV] = svds(ratingsS,10);
A = userV * v^(1/2);
B = v^(1/2) * transpose(trackV);

%Learning steps
while temp < 10000
    ndx = randperm(numel(ratingsS),1);
    [row,col] = ind2sub(size(ratingsS),ndx);
    if ratingsS(row,col)>0
        
        %Calculating the error in the prediction.
        vectorA = A(row,:);
        vectorB = B(:,col);
        error = (ratingsS(row,col) - sum(vectorA * vectorB));

        %This kinda works
        %{
        for i=1:numel(vectorA)
        tempA = A(row,i);
           A(row,i) = A(row,i) + learn * (error * B(i,col) - reg * A(row,i));
           B(i,col) = B(i,col) + learn * (error * tempA - reg * B(i,col));
        end
        %}
        %From slides

        for i=1:numel(vectorA)
           tempA = A(row,i);
           A(row,i) = A(row,i) + learn * error * B(i,col) - reg * A(row,i);
           B(i,col) = B(i,col) + learn * error * tempA - reg * B(i,col);
        end
        
        temp = temp + 1;
    end
end

        predRatings = A * B;
rmse = sqrt(immse(ratings, predRatings));