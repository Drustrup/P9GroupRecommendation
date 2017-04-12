%Returns a top10 list of movies using markov chain
%State space is all movies
function result = markovChain(topK)
[row,col] = size(topK);     %Row and col of size topK
k = col;                    %Of size k
movies = unique(topK);      %Find all unique movie ids
n = size(movies);           %Number of candidates
result = zeros(1, k);       %Set the size of result

transMatrix = zeros(n);     %Transition matrix for each item

%Calculate the transisition matrix
for i=1:n                   %Populate the result matrix with first k indices
    for j=1:n
        %Compare all
        if i==j
            %stuff
        else
            %stuff
        end
    end
end

end