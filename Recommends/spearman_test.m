clear all;

%ratings = importdata('matrix/mml/matrix_SVD++.txt');

A = [11 13 12 14 15 16];
B = [13 11 12 14 17 15];
C = [18 14 12 17 19 11];

users = [A;B;C];
[userCount, itemCount] = size(users); 

S = union(C,union(A,B));
n = numel(S);
W = zeros(n,n);
P = 1:n;
for j = 1 : n
    c = S(j);
    for z = 1 : n
        for i = 1 : userCount
            [v,indexC] = find(users(i,:)==c);
            if ~isnan(indexC)
                W(j,z) = W(j,z) + sqrt((indexC / itemCount - z / n)^2) ; 
            end
        end   
    end
end

W = (W * -1) + 5;   
[val, mi, mj]=bipartite_matching(W);


result = zeros(1,6);
for i = 1 : 6
    result(i) = S(mj(i));
end
