%Connection Comparison

%input a 3-layer network, this will vary the number of connections the
%first layer has to the second

%example specific
L = [6 5 1];
runs = 40;


%general

%function[ x ] = ConnectionComparison(L, runs)
numofconnections = 1:L(2);
error = zeros(1,L(2));  

for i = 1:L(2)-1   %the L(2) error entry will always have 0 error because all information is passed to everyone in that case
    error(i) = ConnectionTester3(L,[i 1],runs)
end


error;
plot(numofconnections,error)

%x = 
    