function rxSignal = huffmanDecod(letters, frequencies, txBitHuffman)

Codeword = huffman(letters, frequencies); %Codewords generated from huffman algorithm

block = [];
fragments = [];
txBitHuffman_dynamic = txBitHuffman(:); %copy of transmitted bits

%fragmentation of transmitted bits into chunks of valid codewords
while length(txBitHuffman_dynamic)>0
    block_size=0;
    
    for n = 1:length(txBitHuffman_dynamic)
        block = [block, txBitHuffman(n)];
        block_size = block_size+1;
        for m = 1:length(Codeword)
          if length(block) == length(cell2mat(Codeword(m)))
              if block == cell2mat(Codeword(m))
                 fragments = [fragments, Codeword(m)];

                   block = [];
                   
                   
              end
             end
        end
    end
    txBitHuffman_dynamic(1:block_size)=[];

end

%mapping the obtained fragments to letters (or symbols)
rxSignal =[];
for k = 1:length(fragments)
    for l = 1:length(Codeword)
        if length(cell2mat(Codeword(l))) == length(cell2mat(fragments(k)))
            if cell2mat(Codeword(l)) == cell2mat(fragments(k))
                 rxSignal = [rxSignal, letters(l)];
            end
        end
    end
end

end