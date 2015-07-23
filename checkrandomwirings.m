function[ x, opt, nonopt, skipped ] = checkrandomwirings(L, k)
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

tempConn1 = zeros(L(2),L(1));
tempConn2 = zeros(L(3),L(2));


for i = 1:k  % run this many samples
    for j = 1:L(1)
        wiringInt = randi((2^(L(2)))-1);
        tempConn1(:,j) = convertToConnection(str2num(dec2bin(wiringInt)),L(2),1); %convert j to bInt to connections
    end
    if prod(sum(tempConn1,2))*prod(sum(tempConn1)) == 0    %check for bad wirings
        badConn = 1;
        skipped = skipped +1;
    end
    
    if badConn == 0
        % do 2 to 3
        for j = 1:L(2)
            wiringInt = randi((2^(L(3)))-1);
            tempConn2(:,j) = convertToConnection(str2num(dec2bin(wiringInt)),L(3),1); %convert j to bInt to connections
        end
        
        if prod(sum(tempConn2,2))*prod(sum(tempConn2)) == 0    %check for bad wirings
            badConn = 1;
            skipped = skipped +1;
        end
        
        if badConn == 0        
            connMat(m+L(1)+1:m+L(1)+L(2),m+1:m+L(1)) = tempConn1;
            connMat(L(2) + L(1)+1:L(3)+L(1)+L(2),L(1)+1:L(2)+L(1)) = tempConn2;            
            [~, vari] = NetEst( connMat , L);
            diff = vari - 1/L(1);
            if (diff)^2 > .0000001
                nonopt = nonopt + 1;
            else
                opt = opt + 1;
            end
        end
    end
    
    
    badConn = 0;
end

%skipped = totalruns - opt - nonopt
x = opt/(opt+nonopt);

end