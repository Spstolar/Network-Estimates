L = [6 3 1];
ConnNums = [2 1];
runs = 1;
B = zeros(sum(L),sum(L))

% input L = the vector of layers and ConnNums = how many connects each member of
%the layer has to the next layer

%TrialErrors = zeros(1,runs)
error = 0;

for r = 1:runs
    B = ConnectGen(L, ConnNums)
    InfoMatrix = NetEst2(B,L);
    InitialWeights = InfoMatrix(1:L(1),sum(L))

end



z = 0;