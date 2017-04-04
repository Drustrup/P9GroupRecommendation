function [result] = getTopKTitles(group, topK)

data = importdata('../dataset/ml-100k/u.item');
idTitle = cell(numel(data),1);

for i = 1 : numel(data)
    line = strsplit(char(data(i)),'|'); 
    idTitle(i,1) = line(1,2);
end

[row, col] = size(topK);
result = cell(row, col + 1);

for i = 1 : row
    result(i,1) = num2cell(group(i)); 
end
for i = 1 : row
    for j = 1 : col
        result(i,j + 1) = idTitle(topK(i,j));
    end
end

result = result';
%{

fid = fopen('eight.txt','a');
fprintf(fid, '%.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\n', result{1,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{2,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{3,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{4,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{5,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{6,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{7,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{8,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{9,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{10,:});
fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{11,:});
fprintf(fid, '\n') ; 
fclose(fid) ;

%}

 %dlmwrite('test.csv', result(2:end,:), '-append') ;
end