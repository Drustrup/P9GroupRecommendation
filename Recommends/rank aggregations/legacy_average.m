%Avg aggregation
function result = average(list,k)

[row,col] = size(list);
topK = ones(row,k);
temp = list;
for i=1:row
    for j=1:k
        [M,I] = max(temp(i,:));
        topK(i,j)= I;
        temp(i,I) = 0;
    end
end
clear temp;
temp = ones(row,k);
[row,col] = size(topK);

for i=1:row
   for j=1:col
       temp(i,j) = mean(list(:,topK(i,j)));
   end
end
result = bordaCount(topK);

%{
temp = temp(:);
topK = topK(:);
i = 1;
while i <= k
    [M,I] = max(temp);
    temp(I) = 0;
    if ~ismember(topK(I),result)
        result(i) = topK(I);
        i = i + 1;
    end
end
%}

%%Normal aggregation

avg = mean(list);

temp = ones(1,k);
for i=1:k
   [M,I] = max(avg);
   temp(i)= I;
   avg(I) = 0;
end
end
