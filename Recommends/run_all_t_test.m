%function [avg, borda, markov] = run_all_t_test()
clear all;
avglist = importdata('meanlists/ndcg_avg.txt');
bordalist = importdata('meanlists/ndcg_borda.txt');
markovlist = importdata('meanlists/ndcg_markov.txt');
spearlist = importdata('meanlists/ndcg_spear.txt');

avg = zeros(5,3);
borda = zeros(5,2);
markov = zeros(5,1);

for i=1:5
    %Average
    [h,p] = ttest(avglist(:,i), bordalist(:,i));
    avg(i,1) = p;
    [h,p] = ttest(avglist(:,i), markovlist(:,i));
    avg(i,2) = p;
    [h,p] = ttest(avglist(:,i), spearlist(:,i));
    avg(i,3) = p;
    
    %borda
    [h,p] = ttest(bordalist(:,i), markovlist(:,i));
    borda(i,2) = p;
    [h,p] = ttest(bordalist(:,i), spearlist(:,i));
    borda(i,3) = p;
    
    %markov
    [h,p] = ttest(markovlist(:,i), spearlist(:,i));
    markov(i,3) = p;
end

%end