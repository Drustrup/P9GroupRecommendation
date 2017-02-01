clear all;
%verifinig code
%{
groups = importdata('test groups/verify.txt');
ratings = importdata('test groups/verifyRatings.txt');
k = 5;
[recommendations, topKRatings] = groupRecommend(ratings, groups,k);
meanList = mean(nDCGRatings(ratings, recommendations, groups, topKRatings, k));
%}

%Real code
groups = importdata('test groups/groupSize12.txt');
ratings = importdata('../dataset/trained_matrix.txt');[row,col] = size(groups);
k = 10;
meanList = zeros(1,row);
for i=1:row
    group = groups(i,:);
    [recommendations, topKRatings] = groupRecommend(ratings, group,k);
    meanList(i) = mean(nDCGRatings(ratings, recommendations, group, topKRatings, k));
end
temp = sum(meanList)/row;

