function[ y ] = ThreeLayerTestsPMSEVarSure( p )
%S is the vector of the number of agents you want in each layer
%this function plots the percentage of optimal wirings sampling
%from a network with S(1) agents in the top layer and S(2) in the second,
%using a prob of p for each connection.


samples = 20000;
covOpt =zeros(1,10);
varOpt =zeros(1,10);
sureOpt =zeros(1,10);
averageNonoptMse =zeros(1,10);
averageTotalMse =zeros(1,10);
varAverageMSE =zeros(1,10);
sureAverageMSE = zeros(1,10);


for j = 2:10
    for i = 2:10
        [covOpt(i), varOpt(i), sureOpt(i) , averageNonoptMse(i), averageTotalMse(i),varAverageMSE(i), sureAverageMSE(i)]  = checkrandomwirings6([i j 1], samples, p);
    end
   
    %simplified 1 agent in first layer case
    covOpt(1) = 1;
    varOpt(1) = 1;
    sureOpt(1) = 1;
    averageNonoptMse(1) = 0;
    averageTotalMse(1) = 0;
    varAverageMSE(1) = 0;
    sureAverageMSE(1) = 0;

    %%Including Headers
    %turn the headers into a single comma seperated string if it is a cell
    %array,
    
    r = 0;
    c = 0;  %don't need offset
    
    headers = transpose(cellstr(char('covOpt', 'varOpt', 'sureOpt', 'averageNonoptMse', 'averageTotalMse', 'varAverageMSE', 'sureAverageMSE')));
    header_string = headers{1};
    for i = 2:length(headers)
        header_string = [header_string,',',headers{i}];
    end
    
    %if the data has an offset shifting it right then blank commas must
    %be inserted to match
    if r>0
        for i=1:r
            header_string = [',',header_string];
        end
    end
    
    %write the string to the designated file
    
    fileName = strcat(int2str(j),'inL2.csv')
    
    fid = fopen(fileName,'w');
    fprintf(fid,'%s\r\n',header_string);
    fclose(fid);
    
    %%append the data to the file

    y = transpose([covOpt; varOpt; sureOpt; averageNonoptMse; averageTotalMse; varAverageMSE; sureAverageMSE]);
    % Call dlmwrite with a comma as the delimiter   
    dlmwrite(fileName, y,'-append','delimiter',',','roffset', r,'coffset',c);
end

end