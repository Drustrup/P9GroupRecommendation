clear all;
users = 1:943;
groups = zeros(1000,4);
[row,col]= size(groups);

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