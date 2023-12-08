clear
clear all
clc

tx_codeword = [1 0 0 0 1]; %transmitted codeword
one_bit_error = [0 1 0 0 0]; %one bit error
rx_codeword = xor(tx_codeword,one_bit_error); %received codeword

G = [1 0 0 0 1; 0 1 0 1 1]; % defining a generator matrix

[k n] = size(G); %number of cols and rows
no_par = n-k; %no of parity bits

P = G(:, k+1:n); %parity bits
H = [P' eye(no_par)]; %H matrix


for i = 1 : 2^k  
  % Iterate through Vector with Specified Increment 
  % or in simple words here we are decrementing 4 till we get 1    
  for j = k : -1 : 1 
    if rem(i - 1, 2 ^ (-j + k + 1)) >= 2 ^ (-j + k)
      u(i, j) = 1;
    else
      u(i, j) = 0;
    end
  end
end
% Generate CodeWords
linear_code = rem(u * G, 2)

one_bit_error_matrix = [eye(n)]; % matrix to generate 1 bit distortion in each row of the linear code

for ii = 1:2^k %constructing a standard array 
    standard_array(1, ii*n-n+1:ii*n) = linear_code(ii,:);
    standard_array(2:2+n-1, (ii-1)*n+1:ii*n) = xor(linear_code(ii,:) ,one_bit_error_matrix)
end

for jj = 1:1+k %matching the received codeword with a codeword in the standard array
    for kk = 1:2+n-1
        if standard_array(kk, jj*n-n+1:jj*n) == rx_codeword %categorizing the codeword
        corrected_codeword = standard_array(1, jj*n-n+1:jj*n); 
        end
    end
end

