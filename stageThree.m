function matrixLeveln = stageThree(rxBits, setNumber)

%00 01 10  11    0 1 2 3    1 2 3 4
stageThreeMatrix = [{0,2 ; 2,0 ; 1,1 ; 1,1}  {1,1 ; 1,1 ; 2,0 ; 0,2} ...
    {1,1 ; 1,1 ; 0,2 ; 2,0} {2,0 ; 0,2 ; 1,1 ; 1,1} ];%map for bits with higher index

Bits = rxBits(2*setNumber-1: 2*setNumber);
 %use the matrix corresponding to Bits as given by stageThreeMatrix for computation 
matrixLeveln = cell2mat(stageThreeMatrix(:,2*(bin2dec(num2str(Bits))+1)-1: 2*(bin2dec(num2str(Bits))+1) ));

end