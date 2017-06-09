%Does not scale with other rec sizes. Only k=10.
clear all;
tic;

%SET groupsize TO # YOU WANT DATA FOR; 0 FOR ALL GROUP SIZES
groupsize = 8;

%Import the data
%groupid | user1 | ... | user8 |- contains nulls as 0's
groups = importdata('survey/groups.txt');
%resultid | groupid | ranked item1 | ... | item 10 |-
results = importdata('survey/results.txt');
%userid | pref1 | ... | pref10 |-
userprefs = importdata('survey/userprefs.txt');
%[Users x Items] = rating
ratings = importdata('matrix/matrixmml_svd++_3-4-17.txt');

[res_num, res_size] = size(results.data);

ndcglist = zeros(1,res_num);  %List of ndcg scores
rndcglist = zeros(1,res_num); %List of rating ndcg scores
ktdlist = zeros(1,res_num);   %List of ktd scores
sfdlist = zeros(1,res_num);   %List of spearman scores

%Rip efficiency
for i=1:res_num
    groupid = results.data(i,2);                %Find the group id

    %REFACTORING TASK: if 2 results have same groupid recs is 2xk -> error
    recs = results.data(results.data(:,2) == groupid, 3:12);

    gindex = find(groups.data(:,1) == groupid); %Find index in groups
    userids = groups.data(gindex,2:9);          %Find all userids in group
    
    users = zeros(8,10);    %Make matrix holding up to 8 users and prefs
    userratings = zeros(8,10);   %matrix holding up to 8 users and ratings
    
    for n=1:8   %Get user preferences for group
        uid = userids(n);
        if(uid ~= 0)  %Smaller groups have 0 as missing users
            upid = find(userprefs.data(:,1) == uid);    %Find userpref id
            users(n,:) = userprefs.data(upid,2:11);     %Store userprefs
        
            for m=1:10  %Find ratings
                ritemid = users(n,m);    %id of rated item
                userratings(n,m) = ratings(uid, ritemid);   %Store top ratings
            end
        end
    end
    
    %Remove 0s
    users(~any(users, 2), :)=[];                %Rows
    userratings(~any(userratings, 2), :)=[];    %Rows
    userids(:, ~any(userids, 1))=[];            %Columns
    
    
    %Prep for  distance measures
    [r,c] = size(users);
    if(groupsize == 0 || r == groupsize)    %Make check on groupsize
    
        %Calculate ndcg and rating ndcg for the group
        ndcglist(1,i) = mean(nDCG(ratings, recs, userids, 10));
        rndcglist(1,i)= mean(nDCGRatings(ratings, recs, userids, userratings, 10));
    
        kendist = zeros(1, r);
        speardist = zeros(1, r);
        for j=1:r   %Calculate individual distances
            kendist(j) = kendallDistanceTopK(recs, users(j,:));
            speardist(j) = spearmanDistance(recs, users(j,:));
        end
        ktdlist(i) = mean(kendist);
        sfdlist(i) = mean(speardist);
    end
end

ndcglist(:, ~any(ndcglist, 1))=[];  %Columns
rndcglist(:, ~any(rndcglist, 1))=[];  %Columns
ktdlist(:, ~any(ktdlist, 1))=[];  %Columns
sfdlist(:, ~any(sfdlist, 1))=[];  %Columns

num = size(ndcglist, 2);

nDCG = sum(ndcglist)/num; % 1 is good 0 bad
rnDCG= sum(rndcglist)/num;% 1 is good 0 bad
ktd = sum(ktdlist)/num;   % 0 is good 1 bad
sfd = sum(sfdlist)/num;   % 0 is good 1 bad
time = toc;

out = ['nDCG: ', num2str(nDCG)]; 
disp(out);
out = ['aDCG: ', num2str(rnDCG)];
disp(out);
out = ['Kend: ', num2str(ktd)];
disp(out);
out = ['Spea: ', num2str(sfd)];
disp(out);
out= ['Time: ', num2str(time)];
disp(out);
