function[ y ] = ThreeLayerTestsPMSE( p )
%S is the vector of the number of agents you want in each layer
%this function plots the percentage of optimal wirings sampling
%from a network with S(1) agents in the top layer and S(2) in the second,
%using a prob of p for each connection. 


samples = 2000;
%optPer = zeros(9,1);
optPer = zeros(1,9);
avgNonoptMse = zeros(1,9);
avgMse = zeros(1,9);

for j = 2:10
for i = 2:10
    [optPer(i-1),avgNonoptMse(i-1),~,avgMse(i-1),~] = checkrandomwirings5([i j 1], samples, p);
end

y = [optPer; avgNonoptMse; avgMse];


csvwrite(strcat(int2str(j),'inL2.dat'),transpose(y))

end



%bar(y,'stacked')


% legend('2 third layer agents','3 third layer agents','four third layer agents')
% xlabel('agents in the second layer')
% num = int2str(firstAgs);
% title(strcat(num,' Agents In Top Layer'))
end