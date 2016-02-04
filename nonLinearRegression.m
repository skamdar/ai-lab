clear all;
close all;

   [x1 x2 x3 x4 y] = textread("Iris_data_norm_train.txt", "%f, %f, %f, %f, %d");	
   NewData = [x1.*x1 x2.*x2 x3.*x3 x4.*x4 x1.*x2 x1.*x3 x1.*x4 x2.*x3 x2.*x4 x3.*x4 y];
save("-ascii", "extendedTrain.txt", "NewData");

   [x1 x2 x3 x4 y] = textread("iris_data_norm_test.txt", "%f, %f, %f, %f, %d");	
   NewData = [x1.*x1 x2.*x2 x3.*x3 x4.*x4 x1.*x2 x1.*x3 x1.*x4 x2.*x3 x2.*x4 x3.*x4 y];

save("-ascii", "extendedTest.txt", "NewData");
TrainingData = dlmread("extendedTrain.txt", " ");   %taking "," as a delimeter in data file
TestData     = dlmread("extendedTest.txt", " ");





[TrainingRow, TrainingColumn] = size(TrainingData);
[TestRow, TestColumn] = size(TestData);



% seperating Y and X from the above matrix into two submatrix

Train_Y = TrainingData(1:TrainingRow, TrainingColumn);   % As last column is Y 
Train_X = TrainingData(1:TrainingRow, 1:TrainingColumn-1); %AS in out data file all column except last one are for X

%finding psuedo-inverse of X, assuming it exist

Transpose_X = transpose(Train_X);


%inv_X = inv(Train_X);

% finding W
Weight = (inv(Transpose_X*Train_X)*Transpose_X)*Train_Y;

%%%% Now we have testing part 
Error = 0;

for row = 1:TestRow
   if (TestData(row, TestColumn) != TestData(row, 1:(TestColumn-1)))
       Error = Error + 1;
   endif
endfor
   
Error   
