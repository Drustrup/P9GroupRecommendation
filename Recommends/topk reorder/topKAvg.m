function [topK] = topKAvg(topK,ratings, users)

[u, k] = size(topK);
newTopKRatings = zeros(size(topK));
for i=1:u
    userTopK = zeros(u,k);
    for z=1:u   
        for j=1:k
            rating = ratings(users(z),topK(i,j));
            userTopK(z,j) = rating;
        end
    end
    newTopKRatings(i,:) = mean(userTopK);
end

newTopK = zeros(size(topK));
for i=1 : u
    for j=1 : k
        [M,I] = max(newTopKRatings(i,:));
        newTopK(i,j) = topK(i,I);
        newTopKRatings(i,I) = 0;
    end
end

topK = newTopK;
end