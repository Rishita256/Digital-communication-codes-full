function [decodedsetC, bbb2]  = decodSetOne(bba2 )
%bb5_ bb5 bb6
%mapping position in matrix to bits
mapStageOne = [{0,0} {1,1}];

%characterizing states

if bba2 ==1 || bba2==2 
    b=0;
elseif bba2 == 3 || bba2==4 
    b=1;
elseif bba2==5 || bba2 == 6 
    b=2;
elseif bba2==7 || bba2 == 8
    b=3;
end

%obtaining the index of number with smallest value

% finding the index bb of value among above defined states with min hamming distance
if b==0||b==1
    bbb2 = 1;
elseif b==2||b==3
    bbb2 = 2;
end


%finding the bits associated with the index bb
decodedsetC = cell2mat(mapStageOne(2*bbb2-1: 2*bbb2));

end