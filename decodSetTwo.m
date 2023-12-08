function [decodedsetB, bbb1]  = decodSetTwo(bba1, matrixLevelB )
%bb5_ bb5 bb6
%mapping position in matrix to bits
mapStageTwo = [{0,0} {1,1} {1,0} {0,1}];

%characterizing states
if bba1 ==1 || bba1==2 || bba1==5 || bba1 == 6
    b=1;
elseif bba1 == 3 || bba1==4 || bba1==7 || bba1 == 8
    b=0;
end

%obtaining the index of number with smallest value

% finding the index bb of value among above defined states with min hamming distance
if b==1
    [~,bbb1_] = min([matrixLevelB(1) ,matrixLevelB(3)]);
    bbb1 = 2*bbb1_-1;
elseif b==0
    [~,bbb1_] = min([matrixLevelB(2),matrixLevelB(4)]);
    bbb1 = 2*bbb1_;
end


%finding the bits associated with the index bb
decodedsetB = cell2mat(mapStageTwo(2*bbb1-1: 2*bbb1));

end