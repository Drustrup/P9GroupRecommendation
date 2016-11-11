clear all;
learn = 0.001;
reg = 0.03;
temp = 0;
ratings = importdata('../dataset/random/matrix.txt');
%ratings = importdata('../dataset/test.txt');
ratingsS = sparse(ratings);
[userV, v, trackV] = svds(ratingsS,80);
A = userV * v^(1/2);
B = v^(1/2) * transpose(trackV);

while temp < 100000
    ndx = randperm(numel(ratingsS),1);
    [row,col] = ind2sub(size(ratingsS),ndx);
    if ratingsS(row,col)>0
        
        vectorA = A(row,:);
        vectorB = B(:,col);
        
        error = (ratingsS(row,col) - sum(vectorA * vectorB));

        for i=1:numel(vectorA)
           tempA = A(row,i);
           A(row,i) = A(row,i) + learn * (error * B(i,col) - reg * A(row,i));
           B(i,col) = B(i,col) + learn * (error * tempA - reg * B(i,col));
        end
        temp = temp + 1;
    end
end
predRatings = A * B;
rmse = sqrt(immse(ratings, predRatings));
