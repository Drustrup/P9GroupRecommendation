clear all;

%ratings = importdata('matrix/mml/matrix_SVD++.txt');

A = [1 3 2 4 5 6];
B = [3 1 2 4 7 5];
C = [8 4 2 7 9 1];

users = [A;B;C];
[userCount, itemCount] = size(users); 

%A(2,:) = B;

S = union(C,union(A,B));
n = numel(S);
%S = [1 3 2 4 5 6 7 8 9];
S = ['a' 'b'];
W = zeros(1,n);
P = 1:n;
for j = 1 : n
    c = S(j);
    for i = 1 : userCount
        [v,indexC] = find(users(i,:)==c);
        if ~isnan(indexC)
            W(j) = W(j) + indexC / itemCount - j / n ; 
        end
    end    
end

dg = sparse(S,P,W);
h = view(biograph(dg,[],'ShowWeights','on'));
%{
temp = []
for i = 1 : 4
    temp(i,:) = ratings(i,:);
end
[RHO, PVAL] = corr(A,B,'rows','pairwise');
RHO = corr(temp);
%}
