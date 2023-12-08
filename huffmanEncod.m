function txBitHuffman = huffmanEncod(letters, frequencies, txSignal)


Codeword = huffman(letters, frequencies); %codewords generated for the given letters and frequencies

txBitHuffman = []; %txSignal mapped to bits based on huffman algorithm
chr = convertStringsToChars(txSignal);

for k = 1:length(chr)
    for l = 1:length(Codeword)
        if letters(l) == chr(k) %comparing each character to the letters 
            txBitHuffman = [txBitHuffman, cell2mat(Codeword(l))]; %transmitted bits
        end
    end
end


end


