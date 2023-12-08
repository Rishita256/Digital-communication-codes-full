function matrixLevel0 = stageOne(rxBits)

%00 01 10  11    0 1 2 3    1 2 3 4
stageOneMatrix = [{0;2} {1;1} {1;1} {2;0}]; %map for first two bits 

%set 1
set1 = rxBits(1:2); 
%use the matrix corresponding to set1 as given by stageOneMatrix for
%computation and convert it to a 4x1 matrix by repeating elements
matrixLevel0 = cell2mat(repelem(stageOneMatrix(:,(bin2dec(num2str(set1))+1)), 2));

end