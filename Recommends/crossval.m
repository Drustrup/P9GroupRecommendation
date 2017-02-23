clear all;
data = importdata('../dataset/ml-100k/u.data');
RMSE = zeros(1,5);
%{

%fold 1
valData = importdata('../dataset/ml-100k/u1.test');
ratings = importdata('../dataset/ml-100k/u1_matrix.txt');
valRatings = importdata('../dataset/ml-100k/u1_test_matrix.txt');
[RMSE(1), predRatings] = MF(data, valData, ratings, valRatings);
disp('Fold one is done ' + RMSE(1));

%fold 2 
valData = importdata('../dataset/ml-100k/u2.test');
ratings = importdata('../dataset/ml-100k/u2_matrix.txt');
valRatings = importdata('../dataset/ml-100k/u2_test_matrix.txt');
[RMSE(2), predRatings] = MF(data, valData, ratings, valRatings);
disp('Fold two is done ' + RMSE(2));

%fold 3
valData = importdata('../dataset/ml-100k/u3.test');
ratings = importdata('../dataset/ml-100k/u3_matrix.txt');
valRatings = importdata('../dataset/ml-100k/u3_test_matrix.txt');
[RMSE(3), predRatings] = MF(data, valData, ratings, valRatings);
disp('Fold three is done ' + RMSE(3));

%fold 4
valData = importdata('../dataset/ml-100k/u4.test');
ratings = importdata('../dataset/ml-100k/u4_matrix.txt');
valRatings = importdata('../dataset/ml-100k/u4_test_matrix.txt');
[RMSE(4), predRatings] = MF(data, valData, ratings, valRatings);
disp('Fold four is done ' + RMSE(4));
%}
%fold 5
valData = importdata('../dataset/ml-100k/u5.test');
ratings = importdata('../dataset/ml-100k/u5_matrix.txt');
valRatings = importdata('../dataset/ml-100k/u5_test_matrix.txt');
[RMSE(5), predRatings] = MF(data, valData, ratings, valRatings);
disp('Fold five is done ' + RMSE(5));

%Train
valData = importdata('../dataset/ml-100k/u.data');
ratings = importdata('../dataset/ml-100k/matrix.txt');
valRatings = importdata('../dataset/ml-100k/matrix.txt');
[RMSEtrained, predRatings] = MF(data, valData, ratings, valRatings);

avgRMSE = sum(RMSE) / 5;