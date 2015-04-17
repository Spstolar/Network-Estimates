%Connection Comparison

%input a 3-layer network, this will vary the number of connections the
%first layer has to the second

%example specific
L = [15 5 1];
runs = 400;

maxtotalconnections = L(1)*L(2) - L(1);
opt = (1/L(1))*ones(1,1+maxtotalconnections);
%general

%function[ x ] = ConnectionComparison(L, runs)
numofconnections = 1:1+maxtotalconnections;
error = zeros(1,1+maxtotalconnections);  

for i = 1:1+maxtotalconnections
    error(i) = ConnectionTester4(L,i-1,runs)
end



error;
plot(numofconnections,error,numofconnections, opt)
legend('probable number of connections out of the first layer','optimum estimate')
title(L)
%x = 
    