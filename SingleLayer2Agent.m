function [ covOpt, varOpt, sureOpt , averageNonoptMse, averageTotalMse,varAverageMSE, sureAverageMSE] = SingleLayer1Agent( layer2ag, s , p )
%the same as check random wirings but looking at the case when there is
%only 1 agent

%% Some Constants
covOpt = 0;  
varOpt =0;
sureOpt =0;
averageNonoptMse = 0;
% I = zeros(L(1),L(2));
% variances = zeros(1,L(2));
varAverageMSE = 0;
sureAverageMSE = 0;


for i = 1:s
    
    %establish the random wiring
    connMat = double( rand(L(2), 1) < p);
    
    %make sure there is at least one connection
    while sum(sum(connMat)) == 0
        connMat = double( rand(L(2), 1) < p);
    end
    
        
end

