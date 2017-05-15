function [result] = kendallDistanceTopK(X, Y)
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
dif = k-z;
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

for i = 1 : z - 1
    for j = i + 1 : z
        if (zS(i) < zS(j) && zT(i) > zT(j)) || (zS(i) > zS(j) && zT(i) < zT(j))
            count(1) = count(1) + 1;
        end
    end
end

%Case 2: Both i and j appears in one list but only i or j in the other 
sIndex = find(ismember(X,S));
tIndex = find(ismember(Y,T));

count(2) = dif * (k + z + 1) - sum(sIndex)-sum(tIndex);

%Case 3: Only i or j  appers in one list and the opposit in the
count(3) = dif^2;

%Case 4: i and j are both missing in one list
%count(4) = 2 * p * nchoosek(dif, 2);

%temp = ((k-z)*((2+p)*k-p*z + 1 - p) + count(1) - sum(sIndex)-sum(tIndex))/(numel(items)*(numel(items)-1)/2); 
%Khaus = (0.5 * dif * (5 * k - z + 1 ) + count(1) - sum(sIndex)-sum(tIndex))/(numel(items)*(numel(items)-1)/2);
result = (0.5 * (k - z) * (5 * k - z + 1 ) + count(1) - sum(sIndex)-sum(tIndex))/(numel(items)*(numel(items)-1)/2);
%temp = sum(count)/(numel(items)*(numel(items)-1)/2);
%result = sum(count)/(numel(items)*(numel(items)-1)/2);
end