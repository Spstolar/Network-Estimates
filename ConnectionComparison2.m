%Connection Comparison

%input a 3-layer network, this will vary the number of connections the
%first layer has to the second

%example specific
L = [15 5 1];
runs = 400;

opt = (1/L(1))*ones(1,86);
%general

%function[ x ] = ConnectionComparison(L, runs)
numofconnections = 15:100;
error = zeros(1,86);  

for i = 1:86
    error(i) = ConnectionTester4(L,i+14,runs)
end

error(L(2)) = opt(1); %basically assuming this for now until the algorithm is trimmed enough to handle larger networks, this is fine to assume because it is the assumption that all information is received by all second layer agents

error;
plot(numofconnections,error,numofconnections, opt)
legend('probable number of connections out of the first layer','optimum estimate')
title(L)
%x = 
    