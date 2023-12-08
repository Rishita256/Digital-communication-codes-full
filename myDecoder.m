function decod = myDecoder(bits_decod,no_rep_decod)

numBits_decod = length(bits_decod) ;%number of bits in input array

for i = 1 : numBits_decod/no_rep_decod
    value =[];
    for p = 1:no_rep_decod
      value(no_rep_decod-p+1) = bits_decod( no_rep_decod*i - p +1);%rep values of a certain bit
    end
    decod(i) = mode(value);%the value that occurs most number of times is taken to be the correct value
end
end