function [result] = kendallDistanceTopK(X, Y)
%X = [2, 1, 3, 4, 5];
%Y = [8, 9, 10, 11, 12];
%Y = [5, 4, 3, 2, 1];
%Y = [1,9,2,8,4];
items = union(X,Y);
xIndex = zeros(1, numel(items));
yIndex = zeros(1, numel(items));

for i = 1 : numel(X)
   
    [Mx,Ix] = find(items==X(i));
    xIndex(Ix) = items(i);
    
    [My,Iy] = find(items==Y(i));
    yIndex(Iy) = items(i);

end

for i = 1 : numel(items)
    
    if xIndex(i) == 0
        xIndex(i) = NaN;
    end
    
    if yIndex(i) == 0
        yIndex(i) = NaN;
    end    
end

k = numel(X);
Z = intersect(X,Y);
z = numel(Z);
S = setdiff(X,Y);
T = setdiff(Y,X);
dif = numel(S);
p = 0.5;

count = zeros(1,4);

%Case 1: The set {i,j} is in both lists
zS = zeros(1,z);
zT = zeros(1,z);
for i = 1 : z
    zS(i) = xIndex(Z(i));
    zT(i) = yIndex(Z(i));
end

for i = 1 : z - 1
    for j = i + 1 : z
        if (zS(i) < zS(j) && zT(i) > zT(j)) || (zS(i) > zS(j) && zT(i) < zT(j))
            count(i) = count(i) + 1;
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
count(4) = 2*p * (dif/2);

result = sum(count)/(numel(items)*(numel(items)-1)/2);
end