function[ covOpt, varOpt, sureOpt , averageNonoptMse, averageTotalMse,varAverageMSE, sureAverageMSE] = checkrandomwirings6(L, s, p)
%takes the 3 layer breakdown and runs NetEst on s possible connections
%of those layers, now connecting using the binomial distribution with prob
%p

%% Some Constants
covOpt = 0;  % total number of optimal wirings
varOpt =0;
sureOpt =0;
%averageNonoptVar = 0;
averageNonoptMse = 0;
I = zeros(L(1),L(2));
variances = zeros(1,L(2));
varAverageMSE = 0;
sureAverageMSE = 0;

for i = 1:s  % run this many samples
    
    %establish the random wiring
    connMat = double( rand(L(2), L(1)) < p); 
    
    %make sure there is at least one connection
    while sum(sum(connMat)) == 0
        connMat = double( rand(L(2), L(1)) < p);
    end
    
    [resultForC, trialNonoptMse, ~] = OptNetCheck5(connMat, L);
    averageNonoptMse = averageNonoptMse + trialNonoptMse/s;
    %averageNonoptVar = averageNonoptVar + trialNonoptVar/s;
    covOpt = covOpt + resultForC;
    
    %Set up for the estimates that just get variance information
    
    TC = transpose(connMat);
    for k = 1:L(2)
        inputs = sum(TC(:,k));
        if inputs == 0
            I(:,k) = zeros(L(1),1);
        else
            
            for j = 1:L(1)  %only need to add numbers for the top layer entries
                I(j,k) = TC(j ,k)/inputs;
                
            end
        end
    end

    
    for l = 1:L(2)
        variances(l) = sum(I(:,l).^2);
    end
    
        totvar = sum(variances);
    variances = variances/totvar;
    
    varEstimate = zeros(L(1),1);
    sureEstimate = zeros(L(1),1);
    
    %Variance weighted estimate
    
    for m = 1:L(2)
        varEstimate = varEstimate + I(:,m)*variances(m);
    end
    
    %now evaluate the estimate
    
    varTrialMSE = sum((varEstimate - (1/(L(1)))*ones(L(1),1)).^2);
    if varTrialMSE < .0001
        varOpt = varOpt + 1;
    end
    varAverageMSE = varAverageMSE + varTrialMSE/s;
    
    
    %Sure estimate
    for m = 1:L(2)
        sureEstimate = sureEstimate + I(:,m)*variances(m);
    end
    
    %now evaluate the estimate
    [~, J] = min(variances);
    
    sureEstimate = I(:,J);
    
    sureTrialMSE = sum((sureEstimate - (1/(L(1)))*ones(L(1),1)).^2);
    if sureTrialMSE < .0001
        sureOpt = sureOpt + 1;
        %'opt'
    end
    sureAverageMSE = sureAverageMSE + sureTrialMSE/s;
    
    
end

covOpt = covOpt/s;
varOpt = varOpt/s;
sureOpt = sureOpt/s; 
%averageNonoptVar
%averageNonoptMse

if covOpt < 1
    %averageTotalVar = averageNonoptVar + opt*((1/L(1))/s);
    averageTotalMse = averageNonoptMse;
    averageNonoptMse = averageNonoptMse/(1 - covOpt);
    %averageNonoptVar = s*averageNonoptVar/nonopt;
else
    %averageNonoptVar = 1/L(1);
    averageNonoptMse = 0;
    %averageTotalVar = 1/L(1);
    averageTotalMse = 0;
end
    
%     averageNonoptVar 
%     averageNonoptMse 
%     averageTotalVar 
%     averageTotalMse
end