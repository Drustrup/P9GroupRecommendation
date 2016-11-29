%Avg aggregation
function result = average(list)

avg = mean(list);

k = 5;
temp = ones(1,k);
for i=1:k
   [M,I] = max(avg);
   temp(i)= I;
   avg(I) = 0;
end
result = temp;
end
