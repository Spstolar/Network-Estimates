function[ x ] = checkallwirings(L)
%takes the layer breakdown and runs the NetEst on every possible connecting
%of those layers and plots a histogram of the optimal v. nonoptimal ones

numAgents = sum(L);


%% layer 1
%layer1connections = zeros(L(2),L(1));
layer2agents = L(1)+1:L(1)+L(2);

numConn = zeros(1,L(1));
opt = 0;
nonopt = 0;

totalruns = 0;

for i = 1:(L(2)^L(1))
    bees = str2num(dec2base(i-1,3)) + 111;
    nummConn(1) = floor(bees/100);
    bees = mod(bees,100);
    nummConn(2) = floor(bees/10);
    nummConn(3) = mod(bees,10);
    nummConn;
    
    ag1choices = nchoosek(layer2agents,nummConn(1));
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
                    if (vari - 1/L(1)) > 0
                        nonopt = nonopt + 1;
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
opt
nonopt



x = opt/(opt+nonopt);
end