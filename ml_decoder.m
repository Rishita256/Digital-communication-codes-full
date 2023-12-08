clear
clear all
clc

tx_codeword = [1 0 1 0 1]; %transmitted codeword
one_bit_error = [0 1 0 0 0]; %one bit error
rx_codeword = xor(tx_codeword,one_bit_error); %received codeword

G = [1 0 1 0 1; 0 1 0 1 1 ]; % defining a generator matrix

[k n] = size(G); %k = 2; n =5; no_par = 2
no_par = n-k; %no of parity bits

P = G(:, n-k:n); %parity bits
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

for ii = 1:2^k
    hamming_dist = xor(linear_code(ii,:), rx_codeword); %finding the hamming distance
    hamming_dist_sum(ii) = sum(hamming_dist); 
end

[minval index] = min(hamming_dist_sum); %equating codeword with min difference to corrected codeword
corrected_codeword = linear_code(index,:);



