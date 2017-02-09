%Returns a random list of movies
function result = random(topK)
[row,col] = size(topK);     %Row and col of size topK
k = col;                    %Of size k
movies = unique(topK);      %Find all unique movie ids
index = randperm(numel(movies),k); %Make a random permutation of indices
result = zeros(1, k);       %Set the size of result
for i=1:k                   %Populate the result matrix with first k indices
    result(i) = movies(index(i));
end
end