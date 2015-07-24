function[ x, opt, nonopt, skipped ] = checkrandomwiringswvar(L, s)
%takes the layer breakdown and runs NetEst on k possible connections
%of those layers

%% Some Constants
numAgents = sum(L);
layers = length(L);
skipped = 0;
connMat = zeros(numAgents);
connMat(numAgents, numAgents - L(layers - 1):numAgents - 1) = ones(1,L(layers-1));
badConn = 0; % used when we have an agent not receiving info in some layer
opt = 0;  % total number of optimal wirings
nonopt = 0;  % '' nonoptimal wirings
m = 0; %for layer induction


for i = 1:s  % run this many samples
    for k = 1:layers-2
        if badConn == 0
            m = m + L(k);
            tempConn = zeros(L(k+1),L(k));
            
            for j = 1:L(k)
                wiringInt = randi((2^(L(k+1)))-1);
                tempConn(:,j) = convertToConnection(str2num(dec2bin(wiringInt)),L(k+1),1); %convert j to bInt to connections
            end
            
            if prod(sum(tempConn,2)) == 0
                badConn = 1;
                skipped = skipped + 1;
            else
                connMat(m + 1 : m+L(k+1) , m - L(k) + 1 : m) = tempConn;
            end
        end
        
        
    end
    
    
    if badConn == 0
        [~, vari] = NetEst( connMat , L);
        diff = vari - 1/L(1);
        if (diff)^2 > .0000001
            nonopt = nonopt + 1;
        else
            opt = opt + 1;
        end
    end
    
    
    badConn = 0;
    m = 0; % reset m !!!
end

%skipped = totalruns - opt - nonopt
if opt + nonopt == 0
    x = 0;
else
    x = opt/(opt+nonopt);
end

end