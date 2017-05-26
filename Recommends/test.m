clear all;
tic;

groups = importdata('groups/groupSize4.txt');
ratings = importdata('matrix/matrixmml_svd++_3-4-17.txt');

[row,col] = size(groups);
k = 10;
meanList = zeros(1,row);
meanListRatings = zeros(1,row);
kendall = zeros(1,row);
spear = zeros(1,row);
for i=1:row
    group = groups(i,:);
    [recommendations, topKRatings, topK] = groupRecommend(ratings, group,k);
    meanListRatings(i) = mean(nDCGRatings(ratings, recommendations, group, topKRatings, k));
    meanList(i) = mean(nDCG(ratings, recommendations, group, k));
    [r,c] = size(topK);
    kendist = zeros(1, r);
    speardist = zeros(1, r);
    for j = 1 : r
        kendist(j) = kendallDistanceTopK(recommendations, topK(j,:));
        speardist(j) = spearmanDistance(recommendations, topK(j,:));
    end
    kendall(i) = mean(kendist);
    spear(i) = mean(speardist);
end
nDCG = sum(meanList)/row; % 1 is good 0 bad 
nDCGRatings = sum(meanListRatings)/row;
kendlist = kendall;
spearlist = spear;
kendall = sum(kendall)/row; % 1 is bad 0 good
spear = sum(spear)/row;     % 1 is bad 0 good

time = toc;

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

out = ['nDCG: ', num2str(nDCG)]; 
disp(out);
out = ['aDCG: ', num2str(nDCGRatings)];
disp(out);
out = ['Kend: ', num2str(kendall)];
disp(out);
out = ['Spea: ', num2str(spear)];
disp(out);
out= ['Time: ', num2str(time)];
disp(out);