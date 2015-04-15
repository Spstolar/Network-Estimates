function[ z ] = ConnectionTester3(L,ConnNums,runs)

% input L = the vector of layers and ConnNums = how many connects each member of
%the layer has to the next layer


error = 0;
TrialErrors = zeros(1,runs);

for r = 1:runs
    V = ConnectGen(L,ConnNums);
    [InfoMatrix, runerror] = NetEst(V,L);
%     if runerror > 0
%         runerror.2
%         InfoMatrix(1:L(1),sum(L))
%         sum(abs(InfoMatrix(1:L(1),sum(L)) - .05*ones(L(1),1)))
%     end
    error = error + runerror;
    TrialErrors(r) = error;
end



%w = histogram(TrialErrors,10);

z = error/runs;