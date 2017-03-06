clear all

groups = importdata('../Survey/groups/four.txt');
ratings = importdata('matrix/mml/matrix_SVD++.txt');
groups(:,1) = [];
[row,col] = size(groups);
k = 10;
meanList = zeros(1,row);
for i=1:row
    group = groups(i,:);
    [recommendations, topKRatings] = groupRecommend(ratings, group,k);
    %meanList(i) = mean(nDCGRatings(ratings, recommendations, group, topKRatings, k));
    meanList(i) = mean(nDCG(ratings, recommendations, group, k));
end
result = sum(meanList)/row;


%get titles for survey
%{
groups = importdata('../Survey/groups/eight.txt');
ratings = importdata('matrix/matrixmml_svd++.txt');
[row,col] = size(groups);
k = 10;

for i=1:row
    group = groups(i,:);
    [result, topKRatings] = groupRecommend(ratings, group,k);
    
    fid = fopen('../Survey/titles/eight.txt','a');
    fprintf(fid, '%.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\n', result{1,:}) ;
    for j = 2 : k + 1
        fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', result{j,:}) ;
    end 
    fprintf(fid, '\n') ;

    fclose(fid) ;
    
end
%}