function [result] = kendallDistanceTopK(X, Y)
%X = [1,2, 3, 4, 5];
%Y = [1,2, 3, 4, 5];
%Y = [8, 9, 10, 11, 12];
%Y = [5, 4, 3, 2, 1];
%Y = [1,9,2,8,4];
items = union(X,Y);                 %Get the set of all items
xIndex = zeros(1, numel(items));    %List of all indices of set x
yIndex = zeros(1, numel(items));    %Same for y
xVal = xIndex;                      %List of values matching Index
yVal = yIndex;                      %on the same index position

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

k = numel(X);           %Number of positions
Z = intersect(X,Y);     %The shared ids of set X and Y
z = numel(Z);           %# of items in common
S = setdiff(X,Y);       %Ids of items on X, not on Y
T = setdiff(Y,X);       %Ids of items on Y, not on X
dif = k-z;              %# of items not in both sets

count = zeros(1,4);     %Four cases for Kendall, record every result

%Case 1: The set {i,j} is in both lists, and not in same order/position
zS = zeros(1,z);
zT = zeros(1,z);
for i = 1 : z
    [sM,sI] = find(xVal == Z(i));   %Look through shared items
    [tM,tI] = find(yVal == Z(i));
    zS(i) = sI;
    zT(i) = tI;
end

%Count up number of times case 1 applied
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

count(2) = dif * (k + z + 1) - sum(sIndex)-sum(tIndex);     %Find # of times it applies

%Case 3: only i appears in one list, and only j in the other list
count(3) = dif^2;

%Case 4: i and j are both on one list, and both missing on the other
%count(4) = 2 * p * nchoosek(dif, 2);   %Ignore this case, dif possibly too low

%Khaus - converting count to a score
result = (0.5 * (k - z) * (5 * k - z + 1 ) + count(1) - sum(sIndex)-sum(tIndex))/(numel(items)*(numel(items)-1)/2);
end