clear all;
%Import commands for files
%oneKUsers = importdata('../dataset/lastfm-dataset-1K/userid-profile.tsv');
b = importdata('../dataset/test.txt');
%disp command for printing the variables
%disp(oneKUsers);
%disp(b);
%Use the sparse() command to make a sparse representation of a int matrix
sparseB = sparse(b);
%disp(sparseB);
%How to use Nonnegative-MF on a int matrix.
[X,Y] = nnmf(sparseB, 2);
%disp(X);
%disp(Y);
a=[2.3 3.422 -6.121 9 4.55]
fid = fopen('coeffs.txt','wt');  
fprintf(fid,'%f\n',a); 
fclose(fid);