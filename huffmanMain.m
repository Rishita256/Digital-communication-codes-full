clc
clear

letters=['a','b','c','d','e','f']; %occurences

frequencies = [25 10 15 5 40 5]; %frequency of letters

Codeword = huffman(letters, frequencies); %Codewords generated from huffman algorithm

%diplay letters and thier corresponding codeword
disp(['letters','   ','codewords']); 
for index = 1:length(Codeword)
    disp([num2str(letters(index)),'          ',num2str(Codeword{index})]);
end

disp('--------------------------------------------------------------')

txSignal = 'aabbcdeff'; %transmitted symbols/letters

txBitHuffman = huffmanEncod(letters, frequencies, txSignal); %transmitted bits

disp('transmitted Bits')
disp(num2str(txBitHuffman))

disp('--------------------------------------------------------------')

rxSignal = huffmanDecod(letters, frequencies, txBitHuffman); %received signals

disp('received symbols')
disp(rxSignal)