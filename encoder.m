function rxBits = encoder(txBits, g)

%txBits = [0,0,0,1,0,0]; %transmitted data

%g = [1,0,1;1,1,1]; %generator matrix

n = 2; %number of cols in generator  
K = 2; %window size

%memData = [zeros(1,K)];

shiftData = [txBits,zeros(1,K)];

[~,c] = size(shiftData);

G = [zeros(n,c-K-1),g];


rxBits = [];

for ii = 1:length(txBits)

xorValue = mod(sum(transpose(bitand(G,shiftData))),2);
rxBits = [rxBits,xorValue]; %received bit
shiftData = circshift(shiftData,1); % shifting position of 1 for each iteration
end

end