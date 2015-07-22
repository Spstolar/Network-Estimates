function[ x ] = checkallwirings(L)
%takes the layer breakdown and runs the NetEst on every possible connecting
%of those layers and plots a histogram of the optimal v. nonoptimal ones

numAgents = sum(L);
layers = length(L);



fileID = fopen('result.txt','w');
formatSpecHeader = 'The layout is %1.0f - %1.0f - %1.0f.\n';
fprintf(fileID,formatSpecHeader,L(1),L(2),L(3));

%% layer 1
%layer1connections = zeros(L(2),L(1));
layer2agents = L(1)+1:L(1)+L(2);

numConn = zeros(1,L(1)); %how many agents each layer 1 agent sends to

%nummConn = zeros(1,numAgents - L(layers - 1) - 1)  %the vector of how many
%agents each agent sends to

opt = 0;
nonopt = 0;

totalruns = 0;

%we use increment to base L(1) conversion to track all possibilities
%this is useful to convert every digit up one for the interpretation

onestring = '1';
for i = 1:L(1)-1
    onestring = strcat(onestring,'1');
end
onesint = str2num(onestring);

for i = 1:(L(2)^L(1))
    layer1connectionsdigit = str2num(dec2base(i-1,L(1))) + onesint;
    
    % turn the digit of connections into an array
    for turntovec = 1:L(1)
        nummConn(turntovec) = floor(layer1connectionsdigit/(10^(L(1) - turntovec)));
        layer1connectionsdigit = mod(layer1connectionsdigit,(10^(L(1) - turntovec)));
    end
    
%     nummConn(1) = floor(layer1connectionsdigit/100);
%     layer1connectionsdigit = mod(layer1connectionsdigit,100);
%     nummConn(2) = floor(layer1connectionsdigit/10);
%     nummConn(3) = mod(layer1connectionsdigit,10);
%     nummConn;
    
    ag1choices = nchoosek(L(1)+1:L(1)+L(2),nummConn(1));
    ag2choices = nchoosek(layer2agents,nummConn(2));
    ag3choices = nchoosek(layer2agents,nummConn(3));
    
    for ag1it = 1:nchoosek(L(2),nummConn(1))
        for ag2it = 1:nchoosek(L(2),nummConn(2))
            for ag3it = 1:nchoosek(L(2),nummConn(3))
                %counting how many different possibilites we run through;
                totalruns = totalruns + 1;
                
                ag1 = [1 ag1choices(ag1it,:)];
                ag2 = [2 ag2choices(ag2it,:)];
                ag3 = [3 ag3choices(ag3it,:)];
                %some connections may be invalid as they don't have agents
                %in the second layer receiving info from anyone, so we skip
                %these.
                skip = 0;
                ourConnections = ConnectionMatrix(numAgents,ag1, ag2, ag3,[4 7],[5 7],[6 7]);
                if (sum(ourConnections(4,:)) * sum(ourConnections(5,:)) * sum(ourConnections(6,:))) == 0
                    skip = 1;
                end
                
                if skip == 0
                    [I, vari] = NetEst( ourConnections , L);
                    
                    
                    diff = vari - 1/L(1);
                    if (vari - 1/L(1))^2 > .0000001
                        nonopt = nonopt + 1;
                        fprintf(fileID,'Nonopt: [  ');
                        formatSpecNonopt = '%hd  ';
                        fprintf(fileID,formatSpecNonopt,ag1);
                        fprintf(fileID,'], [  ');
                        formatSpecNonopt = '%hd  ';
                        fprintf(fileID,formatSpecNonopt,ag2);
                        fprintf(fileID,'], [  ');
                        formatSpecNonopt = '%hd  ';
                        fprintf(fileID,formatSpecNonopt,ag3);
                        fprintf(fileID,']\n');
                    else
                        opt = opt + 1;
                    end
                    
                end
            end
        end
    end
end

totalruns
skipped = totalruns - opt - nonopt

x = opt/(opt+nonopt);

formatSpec = 'The percentage of optimal wirings is %3.4f.\n';
fprintf(fileID,formatSpec,x);
fprintf(fileID,'Total %hd \n',opt+nonopt);
fprintf(fileID,'Optimal: %hd \n',opt);
fprintf(fileID,'Nonoptimal: %hd \n',nonopt);
fclose(fileID);
end