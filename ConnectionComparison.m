%Connection Comparison

%input a 3-layer network, this will vary the number of connections the
%first layer has to the second

%example specific
L = [20 15 1];
runs = 400;

opt = (1/L(1))*ones(1,L(2));
%general

%function[ x ] = ConnectionComparison(L, runs)
numofconnections = 1:L(2);
error = zeros(1,L(2));  

for i = 1:L(2)-1   
    error(i) = ConnectionTester3(L,[i 1],runs)
end

error(L(2)) = opt(1); %basically assuming this for now until the algorithm is trimmed enough to handle larger networks

error;
plot(numofconnections,error,numofconnections, opt)
legend('average error per connections out of each top layer agent','optimum estimate')
title('19-15-1')
%x = 
    