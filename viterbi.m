clear
clc


%00 01 10  11    0 1 2 3    1 2 3 4
stageOneMatrix = [{0;2} {1;1} {1;1} {2;0}]; %map for first two bits 

stageTwoMatrix = [{0;2;1;1} {2;0;1;1} {1;1;0;2} {1;1;2;0} ]; %map for second two bits  

stageThreeMatrix = [{0,2 ; 2,0 ; 1,1 ; 1,1}  {1,1 ; 1,1 ; 2,0 ; 0,2} {1,1 ; 1,1 ; 0,2 ; 2,0} {2,0 ; 0,2 ; 1,1 ; 1,1} ];
%map for bits with higher index 


rxBits = [0 0 0 0 0 0 0 0 1 1 0 0 ] %[0 0  0 0   1 1   0 1   1 1  0 0] %received bits 
% bits are taken two at a time - set
%the given recieved code has 6 sets

%set 1
set1 = rxBits(1:2); 
%use the matrix corresponding to set1 as given by stageOneMatrix for
%computation and convert it to a 4x1 matrix by repeating elements
matrixLevel0 = cell2mat(repelem(stageOneMatrix(:,(bin2dec(num2str(set1))+1)), 2));


%set2
set2 = rxBits(3:4);
%use the matrix corresponding to set2 as given by stageTwoMatrix for
%computation
matrixLevel1 = cell2mat(stageTwoMatrix(:,(bin2dec(num2str(set2))+1)));


%add the two matrices to get a 4x1 matrix and convert that into a 4x2
%matrix by repeating elements
matrixLevel2 = matrixLevel0 + matrixLevel1;
matrixLevel3 = reshape(repelem(matrixLevel2,2), [4,2]);

%set3
set3 = rxBits(5:6);
%use the matrix corresponding to set3 as given by stageThreeMatrix for
%computation 
matrixLevel4 = cell2mat(stageThreeMatrix(:,2*(bin2dec(num2str(set3))+1)-1: 2*(bin2dec(num2str(set3))+1) ));


%add the two matrices to get a 4x2 matrix 
matrixLevel5 = matrixLevel3 + matrixLevel4;

%create a matrix containing the min value of each row  and convert this 4x1
%matrix to a 4x2 matrix by repetition
[min_matrixLevel5,jj] = min(matrixLevel5,[],2);
matrixLevel6 = reshape(repelem(min_matrixLevel5,2), [4,2]);

%set4
set4 = rxBits(7:8);
%use the matrix corresponding to set3 as given by stageThreeMatrix for
%computation
matrixLevel7 = cell2mat(stageThreeMatrix(:,2*(bin2dec(num2str(set4))+1)-1: 2*(bin2dec(num2str(set4))+1) ));

%add the two matrices to get a 4x2 matrix 
matrixLevel8 = matrixLevel6 + matrixLevel7;

%create a matrix containing the min value of each row  and convert this 4x1
%matrix to a 4x2 matrix by repetition
[min_matrixLevel8,kk] = min(matrixLevel8,[],2);
matrixLevel9 = reshape(repelem(min_matrixLevel8,2), [4,2]);

%set5 
set5 = rxBits(9:10);
%use the matrix corresponding to set3 as given by stageThreeMatrix for
%computation
matrixLevel10 = cell2mat(stageThreeMatrix(:,2*(bin2dec(num2str(set5))+1)-1: 2*(bin2dec(num2str(set5))+1) ));

%add the two matrices to get a 4x2 matrix
matrixLevel11 = matrixLevel9 + matrixLevel10;

%create a matrix containing the min value of each row  and convert this 4x1
%matrix to a 4x2 matrix by repetition
[min_matrixLevel11,mm] = min(matrixLevel11,[],2);
matrixLevel12 = reshape(repelem(min_matrixLevel11,2), [4,2]);
  
%set6
set6 = rxBits(11:12);
matrixLevel13 = cell2mat(stageThreeMatrix(:,2*(bin2dec(num2str(set6))+1)-1: 2*(bin2dec(num2str(set6))+1) ));

%add the two matrices to get a 4x2 matrix
matrixLevel14 = matrixLevel12 + matrixLevel13;

%create a matrix containing the min value of each row  and convert this 4x1
%matrix to a 4x2 matrix by repetition
[min_matrixLevel14,nn] = min(matrixLevel14,[],2);

% matrixLevel15 = reshape(repelem(min_matrixLevel14,2), [4,2])

%mapping position in matrix to bits
mapStageThree = [{0,0} {1,1} {1,0} {0,1} {1,1} {0,0} {0,1} {1,0}];
mapStageTwo = [{0,0} {1,1} {1,0} {0,1}];
mapStageOne = [{0,0} {1,1}];

%obtaining the index of number with smallest value
[~,bb6] = min(min_matrixLevel14);
if nn(bb6) == 1
    index = bb6;
elseif nn(bb6) == 2
    index = bb6+4;
end
index = 1;
%finding the bits associated with the index bb
decodedset6 = cell2mat(mapStageThree(2*index-1: 2*index));

%characterizing states
if bb6 ==1 || bb6==2
    b=1;
elseif bb6 == 3 || bb6==4
    b=0;
end

%obtaining the index of number with smallest value
if b==1
    [~,bb5_] = min([matrixLevel11(1, :) ,matrixLevel11(3,:)]);
    if bb5_ == 1|| bb5_ == 3
      bb5 = bb5_;
    else
      bb5 = bb5_+3;
    end
elseif b==0
    [~,bb5_] = min([matrixLevel11(2,:),matrixLevel11(4,:)]);
    if bb5_ == 1|| bb5_ == 3
      bb5 = bb5_+1;
    else
      bb5 = bb5_+4;
    end
end

%finding the bits associated with the index bb
decodedset5 = cell2mat(mapStageThree(2*bb5-1: 2*bb5));

%defining possible previous states
if bb5 ==1 || bb5==2
    b=1;
elseif bb5 ==3 || bb5==4
    b=0;
end

 % finding the index bb of value among above defined states with min hamming distance
if b==1
    [~,bb4_] = min([matrixLevel8(1, :) ,matrixLevel8(3,:)]);
    if bb4_ == 1|| bb4_ == 3
      bb4 = bb4_;
    else
      bb4 = bb4_+3;
    end
elseif b==0
    [~,bb4_] = min([matrixLevel8(2,:),matrixLevel8(4,:)]);
    if bb4_ == 1|| bb4_ == 3
      bb4 = bb4_+1;
    else
      bb4 = bb4_+4;
    end
end

%finding the bits associated with the index bb
decodedset4 = cell2mat(mapStageThree(2*bb4-1: 2*bb4));

%defining possible previous states
if bb4 ==1 || bb4==2
    b=1;
elseif bb4 ==3 || bb4==4
    b=0;
end


 % finding the index bb of value among above defined states with min hamming distance
if b==1
    [~,bb3_] = min([matrixLevel5(1, :) ,matrixLevel5(3,:)]);
    if bb3_ == 1|| bb3_ == 3
      bb3 = bb3_;
    else
      bb3 = bb3_+3;
    end
elseif b==0
    [~,bb3_] = min([matrixLevel5(2,:),matrixLevel5(4,:)]);
    if bb3_ == 1|| bb3_ == 3
      bb3 = bb3_+1;
    else
      bb3 = bb3_+4;
    end
end

%finding the bits associated with the index bb
decodedset3 = cell2mat(mapStageThree(2*bb3-1: 2*bb3));


%defining possible previous states
if bb3 ==1 || bb3==2
    b=1;
elseif bb3 ==3 || bb3==4
    b=0;
end

% finding the index bb of value among above defined states with min hamming distance
if b==1
    [~,bb2_] = min([matrixLevel2(1) ,matrixLevel2(3)]);
    bb2 = 2*bb2_-1;
elseif b==0
    [~,bb2_] = min([matrixLevel2(2),matrixLevel2(4)]);
    bb2 = 2*bb2_;
end

%finding the bits associated with the index bb
decodedset2 = cell2mat(mapStageTwo(2*bb2-1: 2*bb2));


%defining possible previous states
if bb2 ==1 || bb2==2
    b=1;
elseif bb2 ==3 || bb2==4
    b=0;
end


% finding the index bb of value among above defined states with min hamming distance
if b==1
    bb2 = 1;
elseif b==0
    bb2 = 2;
end

%finding the bits associated with the index bb
decodedset1 = cell2mat(mapStageOne(2*bb2-1: 2*bb2));

%final decoded bits
decodedset = [decodedset1 decodedset2 decodedset3 decodedset4 decodedset5 decodedset6]

