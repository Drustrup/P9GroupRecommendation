clear all;

tic;

%groups = importdata('../Survey/groups/eight.txt');
groups = importdata('test groups/groupSize8.txt');
ratings = importdata('matrix/matrixmml_svd++_3-4-17.txt');

%save userpreferences
%{
userPrefs = zeros(943,11);
for i = 1: 943
   user = zeros(1,10);
    for j = 1: 10
        [M,I] = max(ratings(i,:));
        user(j) = I;
        ratings(i,I) = 0;
    end
    userPrefs(i,:) = [i, user];
    fid = fopen('userPrefs.txt','a');
    fprintf(fid,'%.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\t %.f\n', userPrefs(i,:));
    fclose(fid);
end
%}

groups(:,1) = [];
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

