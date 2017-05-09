function [result] = spearmanDistance(X, Y)
%X = [1,2, 3, 4, 5];
%Y = [1,2, 3, 4, 5];
%Y = [8, 9, 10, 11, 12];
%Y = [5, 4, 3, 2, 1];
%Y = [1,9,2,8,4];
items = union(X,Y);
xIndex = zeros(1, numel(items));
yIndex = zeros(1, numel(items));
xVal = xIndex;
yVal = yIndex;

countX = 1;
countY = 1;
for i = 1 : numel(items)
    
    [M,Ix] = find(X==items(i));
    if ~isempty(Ix)
        xIndex(i) = Ix;
        xVal(i) = X(countX);
        countX = countX + 1;
    else 
        xIndex(i) = NaN;
        xVal(i) = NaN;
    end
    
    [M,Iy] = find(Y==items(i));
    if ~isempty(Iy)
        yIndex(i) = Iy;
        yVal(i) = Y(countY);
        countY = countY + 1;
    else
        yIndex(i) = NaN;
        yVal(i) = NaN;    
    end
end

k = numel(X);
Z = intersect(X,Y);
z = numel(Z);
S = setdiff(X,Y);
T = setdiff(Y,X);
l = k + 1;
dif = numel(S);
p = 0.5;

count = zeros(1,4);

%Case 1: The set {i,j} is in both lists
zS = zeros(1,z);
zT = zeros(1,z);
for i = 1 : z
    [sM,sI] = find(xVal == Z(i));
    [tM,tI] = find(yVal == Z(i));
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