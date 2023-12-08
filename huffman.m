function codeword_reversed = huffman(letters, frequencies)

% letters=['a','b','c','d','e','f']; %occurences
% 
% frequencies = [25 10 15 5 40 5]; %frequency of letters

probabilities = frequencies/sum(frequencies); %probability of letters

codeword=cell(1,length(probabilities)); 
codeword_reversed=cell(1,length(probabilities)); %codewords corresponding to the occurences



probabilityDynamic = probabilities(:); %probability at each iteration


nodes=num2cell(1:length(probabilities));  %nodes at different stages in the huffman tree

for k=1:length(probabilities)-1

    [~, indices] = sort(probabilityDynamic); %arranging the probabilty list in ascending order
    

    lowestProbindex = nodes{indices(1)}; %index of lowest probability
    lowestProbability = probabilityDynamic(indices(1)); %value of lowest probability
    
   
    for ii = 1:length(lowestProbindex) %appending 1 for codeword corresponding to lowest probabilty
        codeword{lowestProbindex(ii)} = [codeword{lowestProbindex(ii)}, 1]; 
    end
    
    
    secondlowestProbindex = nodes{indices(2)}; %index of second lowest probability
    secondLowestProbability = probabilityDynamic(indices(2)); %value of second lowest probability
    
    for jj = 1:length(secondlowestProbindex) %appending 0 for codeword corresponding to lowest probabilty
        codeword{secondlowestProbindex(jj)} = [codeword{secondlowestProbindex(jj)}, 0];       
    end

    
    nodes(indices(1:2)) = []; %deleting index of lowest and second lowest probablities from list
    
    
    %adding index of lowest and second lowest probablity as one cell
    nodes{length(nodes)+1} = [lowestProbindex, secondlowestProbindex];
    
    
    probabilityDynamic(indices(1:2)) = [];%deleting lowest and second lowest probablities from list
    
    probabilityDynamic(length(probabilityDynamic)+1) = lowestProbability + secondLowestProbability;
            %adding addition of lowest and second lowest probablity 
    
end


for index = 1:length(codeword)
    codeword_reversed{index}=fliplr(codeword{index}); %flipping the codeword
end


end