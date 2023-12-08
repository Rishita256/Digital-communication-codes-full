function intl = interleaver(bits_intl, no_rep_intl)

numBits_intl =length(bits_intl);% number of bits
n_columns = no_rep_intl;%number of columns in the matrix to be read
reshaped_bits_intl = reshape(bits_intl',[n_columns,numBits_intl/n_columns]); 
%arrange the 1D matrix to from a rectangular matrix
intl = reshape(reshaped_bits_intl, [1, numBits_intl]);
% read the matrix as column-major 

end