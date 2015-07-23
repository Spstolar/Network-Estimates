function[ y ] = fixedFirstLayer( firstAgs )
%plots the percentage of optimal wirings sampling from a three layer
%network with differing amounts of second layer agents

samples = 20001;
numInSecond = floor(1.5*firstAgs);
optPer = zeros(1,numInSecond);
%optPer(1) = 1;  %check the bug here that makes everything skipped

for i = 1:numInSecond
    optPer(i) = multiLayerTester([firstAgs i 1], samples);
end

y = 0;

plot(1:numInSecond,optPer)
legend('percentage of optimal wirings')
xlabel('agents in the second layer')
num = int2str(firstAgs);
title(strcat(num,' Agents In Top Layer'))