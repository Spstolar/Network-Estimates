function[ y ] = fixedFirstLayerForMulti( S )
%S is the vector of the max number of agents you want in each layer
%this function plots the percentage of optimal wirings sampling
%from a network with S(1) agents in the top layer and fewer than or equal
%to S(i) agents in each subsequent layer.


samples = 2000;
firstAgs = S(1);
layers = length(S);
% optPer = zeros(numInThird,numInSecond);
optPer = 0;
L = ones(1, layers);
L(1) = firstAgs;


filename = strcat(num2str(S),'.txt');
csvfilename = strcat(num2str(S),'.csv');
fileID = fopen(filename,'w');
csvFileID = fopen(csvfilename,'w');

for i = 1:layers
    fprintf(csvFileID,strcat('layer',num2str(i),','));
end


fprintf(csvFileID,'optPercent,');


for i = 2: S(2)
    %cycle through
    L(2) = i;
    
    
    
    
    L
    
    optPer = multiLayerTester(L, samples)
    
    

    
    for i = 1:layers
        fprintf(csvFileID,strcat(num2str(L(i)),','));
    end
    
    result = strcat('[',num2str(L),'] = ',num2str(optPer),'\n');
    fprintf(csvFileID,strcat(num2str(optPer),','));
    fprintf(fileID,result);
   
end

fprintf(csvFileID,'\b');
fclose(fileID);
fclose(csvFileID);

y = optPer;

%
% plot(1:numInSecond,optPer(2,:),1:numInSecond,optPer(3,:),1:numInSecond,optPer(4,:))
% legend('2 third layer agents','3 third layer agents','four third layer agents')
% xlabel('agents in the second layer')
% num = int2str(firstAgs);
% title(strcat(num,' Agents In Top Layer'))