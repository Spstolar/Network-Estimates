function[ z ] = ConnectionTester4(L,totalconnections,runs)

% input L = the vector of layers and totalconnections = how many connects should go
% out from the top layer


error = 0;
TrialErrors = zeros(1,runs);

for r = 1:runs
    V = ConnectGen2(L,totalconnections);
    [InfoMatrix, runerror] = NetEst(V,L);
%     InfoMatrix(:,sum(L))
%     runerror
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