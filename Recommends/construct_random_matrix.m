
%x = randi([1 5],15,20);
lowPred = lowA*lowB;
dlmwrite('trained_matrix.txt',lowPred,'delimiter','\t')