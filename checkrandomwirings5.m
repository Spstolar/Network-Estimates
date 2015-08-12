function[ x , averageNonoptMse, averageNonoptVar, averageTotalMse, averageTotalVar] = checkrandomwirings5(L, s, p)
%takes the 3 layer breakdown and runs NetEst on s possible connections
%of those layers, now connecting using the binomial distribution with prob
%p

%% Some Constants
opt = 0;  % total number of optimal wirings
nonopt = 0;  % '' nonoptimal wirings
averageNonoptVar = 0;
averageNonoptMse = 0;

for i = 1:s  % run this many samples
    
    connMat = double( rand(L(2), L(1)) < p);
    
    while sum(sum(connMat)) == 0
        connMat = double( rand(L(2), L(1)) < p);
    end
    
    [resultForC, trialNonoptMse, trialNonoptVar] = OptNetCheck5(connMat, L);
    averageNonoptMse = averageNonoptMse + trialNonoptMse/s;
    averageNonoptVar = averageNonoptVar + trialNonoptVar/s;
    opt = opt + resultForC;
    nonopt = nonopt + 1 - resultForC;
    
end

x = opt/s;
%averageNonoptVar
%averageNonoptMse

if nonopt > 0
    averageTotalVar = averageNonoptVar + opt*((1/L(1))/s);
    averageTotalMse = averageNonoptMse;
    averageNonoptMse = s*averageNonoptMse/nonopt;
    averageNonoptVar = s*averageNonoptVar/nonopt;
else
    averageNonoptVar = 1/L(1);
    averageNonoptMse = 0;
    averageTotalVar = 1/L(1);
    averageTotalMse = 0;
end
    
%     averageNonoptVar 
%     averageNonoptMse 
%     averageTotalVar 
%     averageTotalMse
end