function[ z ] = ConnectionTester2(L,ConnNums,runs)

% input L = the vector of layers and ConnNums = how many connects each member of
%the layer has to the next layer

%TrialErrors = zeros(1,runs)
error = 0;

for r = 1:runs
    InfoMatrix = NetEst2(ConnectGen(L, ConnNums),L);
    InitialWeights = InfoMatrix(1:L(1),sum(L));
    opt = 1/L(1);
    bestweights = opt*ones(L(1),1);
    InitialWeights = InitialWeights - bestweights;
    EstErrors = zeros(L(1),1);
    for n = 1:L(1)
        EstErrors(n,1) = InitialWeights(n,1).^2;
    end
    error = error + sum(EstErrors)/L(1)
end



%w = histogram(TrialErrors,10);

z = error./runs;