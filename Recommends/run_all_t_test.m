%function [avg, borda, markov] = run_all_t_test()
clear all;

%nDCG
ndcg_avglist = importdata('meanlists/ndcg_avg.txt');
ndcg_bordalist = importdata('meanlists/ndcg_borda.txt');
ndcg_markovlist = importdata('meanlists/ndcg_markov.txt');
ndcg_spearlist = importdata('meanlists/ndcg_spear.txt');

%Rating nDCG
andcg_avglist = importdata('meanlists/rating_ndcg_avg.txt');
andcg_bordalist = importdata('meanlists/rating_ndcg_borda.txt');
andcg_markovlist = importdata('meanlists/rating_ndcg_markov.txt');
andcg_spearlist = importdata('meanlists/rating_ndcg_spear.txt');

%kendall tau distance
ktd_avglist = importdata('meanlists/ktd_avg.txt');
ktd_bordalist = importdata('meanlists/ktd_borda.txt');
ktd_markovlist = importdata('meanlists/ktd_markov.txt');
ktd_spearlist = importdata('meanlists/ktd_spear.txt');

%Spearman's Footrule Distance
sfd_avglist = importdata('meanlists/sfd_avg.txt');
sfd_bordalist = importdata('meanlists/sfd_borda.txt');
sfd_markovlist = importdata('meanlists/sfd_markov.txt');
sfd_spearlist = importdata('meanlists/sfd_spear.txt');

%Survey - ndcg 4-8, andcg 4-8, sfd 4-8, kfd 4-8
surveylist = importdata('meanlists/survey.txt');

avg = zeros(6,3);
borda = zeros(6,2);
markov = zeros(6,1);

%Survey
n = 2;
[h,p] = ttest(surveylist(:,n), mean(ndcg_bordalist(:,n)));
[h,p] = ttest(surveylist(:,n+2), mean(andcg_bordalist(:,n)));
[h,p] = ttest(surveylist(:,n+4), mean(sfd_bordalist(:,n)));
[h,p] = ttest(surveylist(:,n+6), mean(ktd_bordalist(:,n)));

[h,p] = ttest(surveylist(:,n), mean(ndcg_markovlist(:,n)));
[h,p] = ttest(surveylist(:,n+2), mean(andcg_markovlist(:,n)));
[h,p] = ttest(surveylist(:,n+4), mean(sfd_markovlist(:,n)));
[h,p] = ttest(surveylist(:,n+6), mean(ktd_markovlist(:,n)));

[h,p] = ttest(surveylist(:,n), mean(ndcg_spearlist(:,n)));
[h,p] = ttest(surveylist(:,n+2), mean(andcg_spearlist(:,n)));
[h,p] = ttest(surveylist(:,n+4), mean(sfd_spearlist(:,n)));
[h,p] = ttest(surveylist(:,n+6), mean(ktd_spearlist(:,n)));

[h,p] = ttest(surveylist(:,n), mean(ndcg_avglist(:,n)));
[h,p] = ttest(surveylist(:,n+2), mean(andcg_avglist(:,n)));
[h,p] = ttest(surveylist(:,n+4), mean(sfd_avglist(:,n)));
[h,p] = ttest(surveylist(:,n+6), mean(ktd_avglist(:,n)));

for i=1:6
    
%     %Average
%     [h,p] = ttest(sfd_avglist(:,i), sfd_bordalist(:,i));
%     avg(i,1) = p;
%     [h,p] = ttestsfd_avglist(:,i), sfd_markovlist(:,i));
%     avg(i,2) = p;
%     [h,p] = ttest(sfd_avglist(:,i), sfd_spearlist(:,i));
%     avg(i,3) = p;
%     
%     %borda
%     [h,p] = ttest(sfd_bordalist(:,i), sfd_markovlist(:,i));
%     borda(i,1) = p;
%     [h,p] = ttest(sfd_bordalist(:,i), sfd_spearlist(:,i));
%     borda(i,2) = p;
%     
%     %markov
%     [h,p] = ttest(sfd_markovlist(:,i), sfd_spearlist(:,i));
%     markov(i,1) = p;
end

%end