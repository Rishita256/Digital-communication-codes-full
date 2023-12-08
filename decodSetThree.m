function [decodedset, bbb]  = decodSetThree(bba, matrixLevelA )
%bb5_ bb5 bb6
%mapping position in matrix to bits
mapStageThree = [{0,0} {1,1} {1,0} {0,1} {1,1} {0,0} {0,1} {1,0}];

%characterizing states
if bba ==1 || bba==2 
    b=0;
elseif bba == 3 || bba==4 
    b=1;
elseif bba==5 || bba == 6 
    b=2;
elseif bba==7 || bba == 8
    b=3;
end

%obtaining the index of number with smallest value
if b==0
    [~,bbb_] = min(matrixLevelA(1, :) );
    if bbb_ == 1
      bbb = 1;
    elseif bbb_ == 2
        bbb = 5;
    end
elseif b==1
    [~,bbb_] = min(matrixLevelA(2,:));
    if bbb_ == 1
      bbb = 2;

    elseif bbb_ == 2
        bbb = 6;

    end
    elseif b==2
    [~,bbb_] = min(matrixLevelA(3,:));
    if bbb_ == 1
      bbb = 3;

    elseif bbb_ == 2
        bbb = 7;

    end
    elseif b==3
    [~,bbb_] = min(matrixLevelA(4,:));
    if bbb_ == 1
      bbb = 4;

    elseif bbb_ == 2
        bbb = 8;

    end
end


%finding the bits associated with the index bb
decodedset = cell2mat(mapStageThree(2*bbb-1: 2*bbb));

end