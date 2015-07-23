function[ y ] = fixedFirstLayerForMulti( firstAgs )
%plots the percentage of optimal wirings sampling from a three layer
%network with differing amounts of second layer agents

samples = 2000;
numInSecond = floor(1*firstAgs);
numInThird = max(floor(.5*firstAgs)+1,4);
optPer = zeros(numInThird,numInSecond);
%optPer(1) = 1;  %check the bug here that makes everything skipped

for i = 1:numInSecond
    for j = 2:numInThird
        optPer(j,i) = multiLayerTester([firstAgs i j 1], samples);
    end
end

y = 0;


plot(1:numInSecond,optPer(2,:),1:numInSecond,optPer(3,:),1:numInSecond,optPer(4,:))
legend('2 third layer agents','3 third layer agents','four third layer agents')
xlabel('agents in the second layer')
num = int2str(firstAgs);
title(strcat(num,' Agents In Top Layer'))