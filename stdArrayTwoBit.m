clear
clear all
clc

tx_codeword = [1 0 1 0 1]; %transmitted codeword
%tx_codeword = [1 1 1 0 0 0 0]; %transmitted codeword
one_bit_error = [0 1 0 0 0]; %one bit error
rx_codeword = xor(tx_codeword,one_bit_error); %received codeword

G = [1 0 1 0 1; 0 1 0 1 1]; % defining a generator matrix
%G = [1 1 1 0 0 0 0; 1 0 0 1 1 0 0; 0 1 0 1 0 1 0 ; 1 1 0 1 0 0 1]; % defining a generator matrix

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
    standard_array_disp(1,ii) = {linear_code(ii,:)}; %display the standard array in form of cells
    standard_array(2:n+1, (ii-1)*n+1:ii*n) = xor(linear_code(ii,:) ,one_bit_error_matrix);
    for ll = 2:n+1
        standard_array_disp(ll, ii) = {standard_array(ll, (ii-1)*n+1:ii*n)};
    end
end

for jj = 1:1+k %matching the received codeword with a codeword in the standard array
    for kk = 1:2+n-1
        if standard_array(kk, jj*n-n+1:jj*n) == rx_codeword %categorizing the codeword
        corrected_codeword = standard_array(1, jj*n-n+1:jj*n); 
        end
    end
end


for i = 1 : 2^n  
  % Iterate through Vector with Specified Increment 
  % or in simple words here we are decrementing 4 till we get 1    
  for j = n : -1 : 1 
    if rem(i - 1, 2 ^ (-j + n + 1)) >= 2 ^ (-j + n)
      set(i, j) = 1;
    else
      set(i, j) = 0;
    end
  end
end


[a b] = size(standard_array_disp); %collecting dimention of standard array


for mm = 1:a %converting the combinations in the array to decimals
    for nn = 1:b
        standard_array_decimal(mm,nn) = bin2dec(num2str(cell2mat(standard_array_disp(mm,nn))));
    end
end

listOfUsedCodeWords = reshape(standard_array_decimal,[],1); %list of codewords in array

listOfUsedCodeWords_bit = dec2bin(listOfUsedCodeWords);

unusedCodeWords = setdiff([0:2^n-1], listOfUsedCodeWords); %list of unused codewords 

unusedCodeWords_bit = dec2bin(unusedCodeWords); %convert list of unused codewords back to binary

for j = 1: n %creating an array of two bit error pattern
   array = zeros(n,n);
        array(:, j) = 1;
   twoBitErrorPattern((j-1)*n+1:(j)*n, 1:n) = xor(eye(n), array);
end


sum1 = 0;%checking for invalid two bit error patterns in the list
for q = 1:n
    sum1 = sum1 + twoBitErrorPattern(:,q);
end

a =[]; 
for i=1:n^2
    if sum1(i) ~= 2
        a(end+1) = i;
    end
end


twoBitErrorPattern([a], :)=[] ;% deleting invalid two bit error patterns from the list
twoBitErrorPattern_unique = unique( twoBitErrorPattern,'row', 'stable') ;% deleting repeated error patterns
twoBitErrorPattern_dec = bin2dec(num2str(twoBitErrorPattern_unique)); %converting the pattern into decimals for comparision
x = double(dec2bin(intersect( twoBitErrorPattern_dec, unusedCodeWords)))-48; % possible combination of two bit error for an all zero code word

if n <7 
    for ii = 1:2^k %completing the standard array 

        standard_array(n+2, (ii-1)*n+1:ii*n) = xor(x(1, :) , linear_code(ii,:));
        standard_array(n+3, (ii-1)*n+1:ii*n) = xor(x(2, :) , linear_code(ii,:));

        standard_array_disp(n+2, ii) = {standard_array(n+2, (ii-1)*n+1:ii*n)};
        standard_array_disp(n+3, ii) = {standard_array(n+3, (ii-1)*n+1:ii*n)};
    end
end

for jj = 1:1+k %matching the received codeword with a codeword in the standard array
    for kk = 1:2+n-1
        if standard_array(kk, jj*n-n+1:jj*n) == rx_codeword %categorizing the codeword
        corrected_codeword = standard_array(1, jj*n-n+1:jj*n); 
        end
    end
end
standard_array_disp

for mm = 1:aa+2 %converting the combinations in the array to decimals
    for nn = 1:b
        standard_array_decimal_final(mm,nn) = bin2dec(num2str(cell2mat(standard_array_disp(mm,nn))));
    end
end
