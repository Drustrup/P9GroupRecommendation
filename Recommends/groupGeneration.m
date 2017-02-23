clear all;
users = 1:943;
tempUsers = users;
groupsFour = zeros(40,4);
groupsFive = zeros(40,5);
groupsSix = zeros(40,6);
groupsSeven = zeros(40,7);
groupsEight = zeros(40,8);

for j = 1 : 40
    for i = 1 : 4
        [V,I] = find(tempUsers == randsample(tempUsers,1));
        groupsFour(j,i) = tempUsers(I);
        tempUsers(I) = [];
    end
end
for j = 1 : 40
    for i = 1 : 5
        [V,I] = find(tempUsers == randsample(tempUsers,1));
        groupsFive(j,i) = tempUsers(I);
        tempUsers(I) = [];
    end
end
for j = 1 : 40
    for i = 1 : 6
        [V,I] = find(tempUsers == randsample(tempUsers,1));
        groupsSix(j,i) = tempUsers(I);
        tempUsers(I) = [];
    end
end
for j = 1 : 40
    for i = 1 : 7
        [V,I] = find(tempUsers == randsample(tempUsers,1));
        groupsSeven(j,i) = tempUsers(I);
        tempUsers(I) = [];
    end
end
for j = 1 : 40
    for i = 1 : 8
        if numel(tempUsers) > 1
            [V,I] = find(tempUsers == randsample(tempUsers,1));
            groupsEight(j,i) = tempUsers(I);
            tempUsers(I) = [];
        else 
            groupsEight(j,i) = tempUsers;
            tempUsers = 0;
        end
        
        if groupsEight(j,i) == 0
            temp = randsample(users,1);
            while ~isnan(find(groupsEight(j,:) == temp))
                temp = randsample(users,1);
            end
            groupsEight(j,i) = temp;
        end
    end
end
    


%{
for j = 1 : numel(groupsFour)
   groupsFour(j,1) = users(i); 
   i = i + 1;
end
for j = 1 : numel(groupsFour)
   groupsFive(j,1) = users(i); 
   i = i + 1;
end
for j = 1 : numel(groupsFour)
   groupsSix(j,1) = users(i); 
   i = i + 1;
end
for j = 1 : numel(groupsFour)
   groupsSeven(j,1) = users(i); 
   i = i + 1;
end
for j = 1 : numel(groupsFour)
   groupsEight(j,1) = users(i); 
   i = i + 1;
end
%}
%legacy
%{
%groups of 4
%{
groups = zeros(1000,4);
for i=1:row
   group = randperm(numel(users),4); 
   groups(i,:) = group;
end
dlmwrite('test groups/groupSize4.txt',groups,'delimiter','\t');
%}

%groups of 8
%{
groups = zeros(1000,8);
for i=1:row
   group = randperm(numel(users),8); 
   groups(i,:) = group;
end
dlmwrite('test groups/groupSize8.txt',groups,'delimiter','\t');
%}
%groups of size 12
%{
groups = zeros(1000,12);
for i=1:row
   group = randperm(numel(users),12); 
   groups(i,:) = group;
end
dlmwrite('test groups/groupSize12.txt',groups,'delimiter','\t');
%}
%groups of size 16
%{
groups = zeros(1000,16);
for i=1:row
   group = randperm(numel(users),16); 
   groups(i,:) = group;
end
dlmwrite('test groups/groupSize16.txt',groups,'delimiter','\t');
%}
%groups of size 20
%{
groups = zeros(1000,20);
for i=1:row
   group = randperm(numel(users),20); 
   groups(i,:) = group;
end
dlmwrite('test groups/groupSize20.txt',groups,'delimiter','\t');
%}

%groups og size 40
%{
groups = zeros(1000,40);
for i=1:row
   group = randperm(numel(users),40); 
   groups(i,:) = group;
end
dlmwrite('test groups/groupSize40.txt',groups,'delimiter','\t');
%}
%}