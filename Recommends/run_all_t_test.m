%function [avg, borda, markov] = run_all_t_test()
clear all;

%nDCG
% avglist = importdata('meanlists/ndcg_avg.txt');
% bordalist = importdata('meanlists/ndcg_borda.txt');
% markovlist = importdata('meanlists/ndcg_markov.txt');
% spearlist = importdata('meanlists/ndcg_spear.txt');

%Rating nDCG
% avglist = importdata('meanlists/rating_ndcg_avg.txt');
% bordalist = importdata('meanlists/rating_ndcg_borda.txt');
% markovlist = importdata('meanlists/rating_ndcg_markov.txt');
% spearlist = importdata('meanlists/rating_ndcg_spear.txt');

%kendall tau distance
% avglist = importdata('meanlists/ktd_avg.txt');
% bordalist = importdata('meanlists/ktd_borda.txt');
% markovlist = importdata('meanlists/ktd_markov.txt');
% spearlist = importdata('meanlists/ktd_spear.txt');

%Spearman's Footrule Distance
avglist = importdata('meanlists/sfd_avg.txt');
bordalist = importdata('meanlists/sfd_borda.txt');
markovlist = importdata('meanlists/sfd_markov.txt');
spearlist = importdata('meanlists/sfd_spear.txt');

avg = zeros(6,3);
borda = zeros(6,2);
markov = zeros(6,1);

for i=1:6
    %Average
    [h,p] = ttest(avglist(:,i), bordalist(:,i));
    avg(i,1) = p;
    [h,p] = ttest(avglist(:,i), markovlist(:,i));
    avg(i,2) = p;
    [h,p] = ttest(avglist(:,i), spearlist(:,i));
    avg(i,3) = p;
    
    %borda
    [h,p] = ttest(bordalist(:,i), markovlist(:,i));
    borda(i,1) = p;
    [h,p] = ttest(bordalist(:,i), spearlist(:,i));
    borda(i,2) = p;
    
    %markov
    [h,p] = ttest(markovlist(:,i), spearlist(:,i));
    markov(i,1) = p;
end

%end