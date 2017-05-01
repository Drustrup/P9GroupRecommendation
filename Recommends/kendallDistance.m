function [result] = kendallDistance(X, Y)
%X = [1, 2, 3, 4, 7];
%Y = [8, 9, 10, 11, 12];
%Y = [7, 4, 3, 2, 1];
items = union(X,Y);
xIndex = zeros(1, numel(items));
yIndex = zeros(1, numel(items));
yTest = numel(items);
xTest = numel(items);
for i = 1 : numel(items)
    
    [M,Ix] = find(X==items(i));
    if isempty(Ix)
        %xIndex(i) = xTest + 1;
        xIndex(i) = 0;
    else 
        xIndex(i) = Ix;
        
    end
    
    [M,Iy] = find(Y==items(i));
    if isempty(Iy)
        %yTest = yTest + 1;
        %yIndex(i) = yTest + 1;
        yIndex(i) = 0;
    else 
        yIndex(i) = Iy;
        
    end
end

nol = numel(items) + 1;
for i = 1 : numel(items)
   if xIndex(i) == 0
       xIndex(i) = nol;
   end
   if yIndex(i) == 0
       yIndex(i) = nol;
   end
end

count = 0;
for i = 1 : numel(items) - 1
    for j = i + 1 : numel(items)
        if xIndex(i) == xIndex(j) || yIndex(i) == yIndex(j)
            count = count + 1;
        elseif (xIndex(i) < xIndex(j) && yIndex(i) > yIndex(j)) || (xIndex(i) > xIndex(j) && yIndex(i) < yIndex(j))
            count = count + 1;
        end
    end
end 

result = count/(numel(items)*(numel(items)-1)/2);
end