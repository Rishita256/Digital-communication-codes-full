function [matrixLeveli,matrixLevelm] = eightElem(matrixA, matrixB)

%add the two matrices to get a 4x2 matrix 
matrixLeveli = matrixA + matrixB;

%create a matrix containing the min value of each row  and convert this 4x1
%matrix to a 4x2 matrix by repetition
[min_matrixLeveli,~] = min(matrixLeveli,[],2);
matrixLevelm = reshape(repelem(min_matrixLeveli,2), [4,2]);


end