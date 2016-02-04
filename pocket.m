clear all;
close all;

Data = dlmread("data.txt", ",");   %taking "," as a delimeter in data file


[DataRow, DataColumn] = size(Data);

DataToTrain = 70; %specify in percent how much percentage of data to be used for training


TrainingRow = floor((DataRow*DataToTrain)/100);


% seperating Y and X from the above matrix into two submatrix
Y = Data(1:DataRow, DataColumn);   % As last column is Y 
X = Data(1:DataRow, 1:(DataColumn-1)); %AS in out data file all column except last one are for X

w = [1 1 1 0];   %starting value of w
w_update = w;
E_in = 0;
E_out = 0;
E_prev = 10000;
Iteration = 1;

while Iteration <= 100

for row = 1:TrainingRow
    output = w*transpose(X(row, 1:(DataColumn-1)));
    if (sign(output) != Y(row, 1))
       E_in++;
       w_update = w_update + Y(row, 1)*X(row, 1:(DataColumn-1));
    endif
endfor

E_in;

%% Now we have testing part
 

Row = TrainingRow + 1;

while Row <= DataRow
    output = w*transpose(X(Row, 1:(DataColumn-1)));
    if (sign(output) != Y(Row, 1))
       E_out = E_out + 1;
    endif
    Row++;
endwhile

E_out;

if (E_in <= E_prev)
   w = w_update;
   E_prev = E_in
endif
         
Iteration++; 
plot(Iteration, E_in,"b");
hold on
plot(Iteration,E_out, "r");
E_in = 0;
E_out = 0;
endwhile
