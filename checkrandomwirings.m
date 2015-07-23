function[ x, opt, nonopt, totalruns, skipped ] = checkrandomwirings(L, k)
%takes the layer breakdown and runs the NetEst on every possible connecting
%of those layers and plots a histogram of the optimal v. nonoptimal ones

numAgents = sum(L);
layers = length(L);

%goal: rewrite in terms of going through all the connection matrix
%possibilites. Converting the base-L(1) run through to a binary type output

% more like run the topleft L(2)xL(1) submatrix of the connection matrix
% through all of it's possibilities, discarding the ones who have zero
% columns
% the submatrix is really just a binary number whose
% ith entry is whether the floor(i/L(1)) agent sends info to the
% mod(i,L(1)) agent

%This will give 2^(L(1)*L(2)) iterations for the three layer

% Product 2^(L(i)*L(i+1)) iterations for the general.

skipped = 0;
connMat = zeros(numAgents);
connMat(numAgents, numAgents - L(layers - 1):numAgents - 1) = ones(1,L(layers-1));
badConn = 0;
opt = 0;
nonopt = 0;
totalruns = 0;
m = 0; %for layer induction

for i = 1:k  % run this many samples
    agentwirings = zeros(1, L(1));
    for j = 1:L(1)
        wiringInt = randi((2^(L(2)))-1);
        tempConn(:,j) = convertToConnection(str2num(dec2bin(wiringInt)),L(2),1); %convert j to bInt to connections
    end
    if prod(sum(tempConn,2))*prod(sum(tempConn)) == 0    %check connections for bad
        badConn =1;
        skipped = skipped +1;
    else
        connMat(m+L(1)+1:m+L(1)+L(2),m+1:m+L(1)) = tempConn;       %if not bad add it to the connMat
        [~, vari] = NetEst( connMat , L);
        diff = vari - 1/L(1);
        if (diff)^2 > .0000001
            nonopt = nonopt + 1;
        else
            opt = opt + 1;
        end
    end
    totalruns = totalruns +1;
end

%skipped = totalruns - opt - nonopt
x = opt/(opt+nonopt);

end