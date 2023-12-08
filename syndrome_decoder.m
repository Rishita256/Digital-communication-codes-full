clear
clear all
clc

tx_codeword = [0 0 0 0 0];%[1 0 0 0 1 ]; %transmitted codeword
one_bit_error = [0 0 0 0 0]; %one bit error
rx_codeword = xor(tx_codeword,one_bit_error); %received codeword

G = [1 0 0 0 1 ; 0 1 0 1 1 ]; % defining a generator matrix

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

coset_array = [zeros(1,n); eye(n)]; %corset array
syndrome_array = [eye(n)* H']; %syndrome array

syndrome = mod([rx_codeword]*syndrome_array,2) %finding the syndrome

if(sum(syndrome)==0)
    error = zeros(1,n);
else
    for jj = 1:n
        if syndrome_array(jj, :)== syndrome
            error = coset_array(jj, :); %finding the error bit for the given syndrome
        
        end
    end
end

corrected_codeword = xor(error, rx_codeword) %correcting the received codeword
