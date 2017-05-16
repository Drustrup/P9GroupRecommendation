function [result] = spearmanDistance(X, Y)
%X = [1,2, 3, 4, 5];
%Y = [1,2, 3, 4, 5];
%Y = [8, 9, 10, 11, 12];
%Y = [5, 4, 3, 2, 1];
%Y = [1,9,2,8,4];
%Y = [5,4,10,2,1];
items = union(X,Y);
xIndex = zeros(1, numel(items));
yIndex = zeros(1, numel(items));

countX = 1;
countY = 1;
for i = 1 : numel(items)
    
    [M,Ix] = find(X==items(i));
    if ~isempty(Ix)
        xIndex(i) = Ix;
        countX = countX + 1;
    else 
        xIndex(i) = NaN;
    end
    
    [M,Iy] = find(Y==items(i));
    if ~isempty(Iy)
        yIndex(i) = Iy;
        countY = countY + 1;
    else
        yIndex(i) = NaN;
    end
end

k = numel(X);
Z = intersect(X,Y);
z = numel(Z);
S = setdiff(X,Y);
T = setdiff(Y,X);


%Case 1: The set {i,j} is in both lists
zS = zeros(1,z);
zT = zeros(1,z);
for i = 1 : z
    [sM,sI] = find(X == Z(i));
    [tM,tI] = find(Y == Z(i));
    zS(i) = sI;
    zT(i) = tI;
end

dist = 0;
for i = 1 : z 
    dist = dist + sqrt((zS(i) - zT(i))^2);
end
sIndex = find(ismember(X,S));
tIndex = find(ismember(Y,T));

result = ((k - z) * (3 * k - z + 1) + dist - sum(sIndex) - sum(tIndex))/(numel(items)^2/2);
end