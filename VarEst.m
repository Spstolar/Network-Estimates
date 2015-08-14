function [ x, averageMSE ] = VarEst( L, s, p )
%This does the estimate for a three layer network by averaging all incoming
%estimates using variance weighting. The output is what percentage of these
%estimates are optimal and what the average error is.

opt = 0;
averageMSE = 0;
I = zeros(L(1),L(2));
variances = zeros(1,L(2));

for i = 1:s
    connMat = double( rand(L(2), L(1)) < p);
    
    while sum(sum(connMat)) == 0
        connMat = double( rand(L(2), L(1)) < p);
    end
    
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
    
    estimate = zeros(L(1),1);
    
    for m = 1:L(2)
        estimate = estimate + I(:,m)*variances(m);
    end
    
    %now evaluate the estimate
    
    trialMSE = sum((estimate - (1/(L(1)))*ones(L(1),1)).^2);
    if trialMSE < .0001
        opt = opt + 1;
    end
    averageMSE = averageMSE + trialMSE/s;
    
end

x = opt/s;

