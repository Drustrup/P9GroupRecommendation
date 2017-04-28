%Returns a top10 list of movies using markov chain
%Strictly adheres to the method described by Dwork et Al, Rank Aggregation Methods
%State space is all movies
%A state can only transition to a state which a majority ranks higher
%Strict addition: A higher ranking is only noted if both items are ranked
function answer = markovChain(topK)
[row,col] = size(topK);     %Row (line of prefs) and col (users) of size topK
users = row;                %Number of users
ansSize = col;              %Size of result returned
movies = unique(topK);      %Find all unique movie ids
n = numel(movies);          %Number of unique items
resSize = n;                %Named var for number of results
result = zeros(1, resSize); %The result matrix
leap = 0.05; %Percentage points to leap


scoreMatrix = zeros(n);     %Score: item is ranked higher than other items
tMatrix = zeros(n)+(leap/n);   %Transition matrix

%Find out which items are ranked highest on compared to each other
for i=1:n       %For every item
    for j=1:n   %Compare with every other item
        id1 = movies(i);
        id2 = movies(j);
        score = 0;  %Positive score -> Majority ranks item higher
                    %Equal/negative score -> Equally ranked or worse
        %Compare all
        if i==j     %Skip itself
            continue;
        else
            for m=1:users       %For every user row
                index1 = find(topK(m,:) == id1); %Find indices
                index2 = find(topK(m,:) == id2);
                if isempty(index1)              %One item isn't rated
                    if not(isempty(index2))     %Other item is rated
                        continue;
                    end
                elseif isempty(index2)          %Other item isn't rated
                    if not(isempty(index1))
                        continue;
                    end
                else                            %both items are rated
                    if index1 < index2          %item1 is preferred
                        score = score + 1;
                    else
                        score = score - 1;
                    end
                end
            end
        end
        %Put comparison scores into transition matrix
        scoreMatrix(i, j) = score;
    end
end

%Populate the transition matrix using scores
for i=1:n       %For every movie
    links = find(scoreMatrix(i,:) > 0); %Find outdegrees
    ele = numel(links);                 %Total # of outdegrees
    tMatrix(i,i) = ((n-ele)/n)*(1-leap);%Move to itself if alternative not better
    
    for j=1:ele   %Every link to every movie
        pos = links(j);
        tMatrix(i, pos) = tMatrix(i, pos) + (1/n)*(1-leap);
    end
end

%POWER ITERATION
V = ones(1,n);
V = V/n;
vec = V;
for i=1:30
    vec = vec * tMatrix;
    vec = vec/norm(vec);
end

%Put the result indices in results
result(1) = 1;      %Insert 1st to compare against
for i=2:n           %Iterate through remaining items
    for j=1:resSize %Iterate through result list
        if(result(j) == 0)  %If empty spot
            result(j) = i;
            break;
        elseif(vec(i) > vec(result(j))) %If bigger than current spot
            if(j < resSize)
                temp = result(j); %Save former result
                result(j) = i;    %Put in new result
                for l=j+1:resSize       %Shift all positions down 1 spot
                    tempo = result(l);
                    result(l) = temp;
                    temp = tempo;
                end
            else
                result(j) = i;
            end
            break;
        end
    end
end

%Convert result indices to movies indices
for i=1:resSize
    for j=i:resSize %Testing for duplicate indices in results.
        if ((result(i) == result(j) && i ~= j) || numel(result) ~= resSize)
            continue; %Set breakpoint here for testing
        end
    end
    result(i) = movies(result(i));
end

%Flip to get the correct answer
result = flip(result);

%Return it
answer = result(1:ansSize);
end