function[ x, opt, nonopt, skipped ] = checkrandomwirings3(L, s, p)
%takes the 3 layer breakdown and runs NetEst on s possible connections
%of those layers, now connecting using the binomial distribution with prob
%p

%% Some Constants
numAgents = sum(L);
layers = length(L);
skipped = 0;
connMat = zeros(L(2),L(1));
badConn = 0; % used when we have an agent not receiving info in some layer
opt = 0;  % total number of optimal wirings
nonopt = 0;  % '' nonoptimal wirings


for i = 1:s  % run this many samples
    for j = 1:L(1)
        wiringInt = randi((2^(L(2)))-1);
        connMat(:,j) = convertToConnection(str2num(dec2bin(wiringInt)),L(2),1); %convert j to bInt to connections
    end
    
    if prod(sum(tempConn,2)) == 0
        badConn = 1;
        skipped = skipped + 1;
    end
     
    if badConn == 0
        if( NetEst3(connMat) == 1)
            opt = opt + 1;
        else
            nonopt = nonopt + 1;
        end   
    end
    
    badConn = 0;
end

%skipped = totalruns - opt - nonopt
if opt + nonopt == 0
    x = 0;
else
    x = opt/(opt+nonopt);
end

end