function [var, mse] = NetEst5( C, L)
%% takes in the connection matrix from layer one to layer two and returns the variance and mse

%NetEst5 Calculates estimates mse and variance given the connection matrix, and will only be
%seeing bad networks. It calculates the best estimate that that networks can acheive
%and evaluates that estimate.

%C is the matrix of connections:
%column i tells you who agent i sends info to
%C_ji = 1 if i -> j and 0 otherwise

%L is the vector that tell you how many agents are in each layer. L(i) is
%the number of agents in layer i, so L = [L(1) L(2) ... L(num of layers)]
%It is possible to determine this from a well formatted connection matrix
%but easier to explicitly input than to code.

%% Example
%It's good to test this on 
%C = ConnectionMatrix(8,[1 4],[2 4 5],[3 5],[4 6],[5 7],[6 8],[7 8])
%L = [3 2 2 1]


%% Constants
N = sum(L);             %total number of agents
K = length(L);          %number of layers

%Delete the rows of zero, because the these are just agents that
%don't receive any info and so are disregarded.
zerocheck = sum(C,2);
removed = 0;

for i = 1:L(2)
    if zerocheck(L(2)-i+1) == 0
        C(L(2)-i+1,:) = [];
        removed = removed + 1;
    end
end

L(2) = L(2) - removed;

I = zeros(L(1),L(2));         %initial info matrix

        

%this gives the matrix whose column i tell you who agent i receives info from
TC = transpose(C);

%% Computation of layers 1 and 2
%The first and second layers are easy to compute without requiring covariance matrix inversion
%, so we do those and leave the third and on layers to an algorithm which uses covariance
%matrices


%We read the info matrix as the matrix of weights each agent gives to other
%agents. So the first L(1) entries of column i tell you how agent i weights
%the first layer agents and this tells us when we have an optimal network
%because the final row will have the first L(1) entries all equal to 1/L(1)
   
%define the info matrix for the second layer
for k = 1:L(2)
    for j = 1:L(1)  %only need to add numbers for the top layer entries
        inputs = sum(TC(:,k));
        I(j,k) = TC(j ,k)/inputs;
        %inputs is the number of top layer agents who send
        %estimate to this layer 2 agent. Won't be zero because we removed
        %the possibility of rows of zeros.
    end
end

Q = zeros(L(2));

for i = 1 :L(2)
    for j = 1:L(2)
        Q(i,j) = transpose(I(:,i))*I(:,j);
    end
end

%Q is the RxR covariance matrix, which may be singular
%Check if it's singular, and if it is de-singularize it, where we
%keep track of what we removed from WF


%         rank(Q) isitsing = singcheck(Q); cond(Q);
%         %<-- for debugging
        
if singcheck(Q) == 1    % checks if the matrix is singular
    [Q, removed] = desing(Q);  % if it is singular, run the desingularization
end

%          WF might have been resized;
inL2 = L(2);   %original number of inputs
[L(2), ~] = size(Q);  %number of independent inputs

%IWF = inv(WF);    %replaced inv(WF) below with /WF
        
b = (ones(1,L(2))/Q)*ones(L(2),1); % the sum of the entries of the inverse of the reduced covariance matrix

weights = (ones(1,L(2))/Q)/b;  % this comes out of min. var. est.
% theory for how to get the optimal
% estimate given covaried inputs

fillw = zeros(1,inL2);  % now turn the weights for the independent
% inputs into weights for all inputs

%we have to add in some zeros if we reduced the covariance matrix
if L(2) < inL2
    p = 1;
    q = 1;
    for fillspot = 1:inL2
        if fillspot == removed(p)
            fillw(fillspot) = 0;
            if p == length(removed)
                removed(p) = 0;
            else
                p = p + 1;
            end
        else
            fillw(fillspot) = weights(q);
            q = q + 1;
        end
    end
    weights = fillw;
end
        
        
est = zeros(L(1),1);

for l = 1:inL2
    est = est + weights(l)*I(:,l);
end

          

%% Debugging and Results
%Some debugging output:
% WF
% inv(WF)
% sum(sum(inv(WF)))
% 1/sum(sum(inv(WF)))
% finalcov
% inv(finalcov)

var = 1/sum(sum(inv(Q)));  %determinant for the final agent's covariance matrix
    %this is the result that the variance 1/the sum of the info matrix
    %entries
    
    %the equal (1) variance network is optimal when var = 1/L(1)
    
    
mse = sum( (est - (1/L(1))*ones(L(1),1)).^2 );

end


