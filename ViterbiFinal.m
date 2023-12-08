clear
clc

txBits = [0,0,0,1,0,0]; %transmitted data
generator = [1,0,1;1,1,1]; %generator matrix


rxBits =encoder(txBits, generator);
%a=eye(12);
% [0 0 0 0 1 1 1 0 1 1 0 0]
% a(3,:)%[0 0  1 1   0 1   1 0   0 1  0 0] ;%received bits 

% bits are taken two at a time - set
%the given recieved code has 6 sets

% set1
matrixLevel0 = stageOne(rxBits);

% set2
matrixLevel1 = stageTwo(rxBits);

%add the two matrices to get a 4x1 matrix and convert that into a 4x2
%matrix by repeating elements

matrixLevel2 = matrixLevel0 + matrixLevel1;
matrixLevel3 = reshape(repelem(matrixLevel2,2), [4,2]);

%set3
matrixLevel4 = stageThree(rxBits,3);
[matrixLevel5,matrixLevel6] = eightElem(matrixLevel3, matrixLevel4);

%set4
matrixLevel7 = stageThree(rxBits,4);
[matrixLevel8,matrixLevel9] = eightElem(matrixLevel6, matrixLevel7);

%set5
matrixLevel10 = stageThree(rxBits,5);
[matrixLevel11,matrixLevel12] = eightElem(matrixLevel9, matrixLevel10);

%set6
matrixLevel13 = stageThree(rxBits,6);


[matrixLevel14,matrixLevel15] = eightElem(matrixLevel12, matrixLevel13);
[min_matrixLevel14,nn] = min(matrixLevel14,[],2);

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
decodedset6 = cell2mat(mapStageThree(2*index-1: 2*index));%set 6

[decodedset5, bb5]  = decodSetThree(bb6,matrixLevel11); %set 5
[decodedset4, bb4]  = decodSetThree(bb5,matrixLevel8); %set 4
[decodedset3, bb3]  = decodSetThree(bb4,matrixLevel5); %set 3
[decodedset2, bb2]  = decodSetTwo(bb3,matrixLevel2); %set 2
[decodedset1, bb1]  = decodSetOne(bb2); %set 1

%final decoded bits
decodedset = [decodedset1 decodedset2 decodedset3 decodedset4 decodedset5 decodedset6];



disp('received bits');
disp(num2str(rxBits));

disp('decoded bits');
disp(num2str(decodedset));
