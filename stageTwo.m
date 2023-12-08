function matrixLevel1 = stageTwo(rxBits)

%00 01 10  11    0 1 2 3    1 2 3 4
stageTwoMatrix = [{0;2;1;1} {2;0;1;1} {1;1;0;2} {1;1;2;0} ]; %map for second two bits  


%set2
set2 = rxBits(3:4);
%use the matrix corresponding to set2 as given by stageTwoMatrix for
%computation
matrixLevel1 = cell2mat(stageTwoMatrix(:,(bin2dec(num2str(set2))+1)));

end