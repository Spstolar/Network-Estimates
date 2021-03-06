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
L(layers) = 1;



filename = strcat(num2str(S),'.txt');
csvfilename = strcat(num2str(S),'.csv');
fileID = fopen(filename,'w');
csvFileID = fopen(csvfilename,'w');

for i = 1:layers
    fprintf(csvFileID,strcat('layer',num2str(i),','));
end


fprintf(csvFileID,'optPercent,');


for i = 1: prod(S)/S(1)
    %cycle through
    for j = 2:layers
        if L(j) == S(j)
            L(j) = 1;
        else
            L(j) = L(j) + 1;
            break
        end
    end
    
    
    %to avoid unnecessary computation do [a 1 1] instead of [a 1 * * *]
    for k = 2:layers-1
        if L(k) == 1
            skip = 1;
            'skipped'
            break
        end
    end
          
    L
    
    if skip == 0
        optPer = multiLayerTester(L, samples)
    else
        optPer = -1
    end
    

    
    for i = 1:layers
        fprintf(csvFileID,strcat(num2str(L(i)),','));
    end
    
    result = strcat('[',num2str(L),'] = ',num2str(optPer),'\n');
    fprintf(csvFileID,strcat(num2str(optPer),','));
    fprintf(fileID,result);
    
    skip = 0;
end

fprintf(csvFileID,'\b');
fclose(fileID);
fclose(csvFileID);

y = 0;

%
% plot(1:numInSecond,optPer(2,:),1:numInSecond,optPer(3,:),1:numInSecond,optPer(4,:))
% legend('2 third layer agents','3 third layer agents','four third layer agents')
% xlabel('agents in the second layer')
% num = int2str(firstAgs);
% title(strcat(num,' Agents In Top Layer'))