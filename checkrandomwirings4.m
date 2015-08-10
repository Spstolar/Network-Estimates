function[ x ] = checkrandomwirings4(L, s, p)
%takes the 3 layer breakdown and runs NetEst on s possible connections
%of those layers, now connecting using the binomial distribution with prob
%p

%% Some Constants
opt = 0;  % total number of optimal wirings
nonopt = 0;  % '' nonoptimal wirings


for i = 1:s  % run this many samples
    
    connMat = double( rand(L(2), L(1)) < p);
    
    resultForC = NetEst4(connMat);
    opt = opt + resultForC;
    nonopt = nonopt + 1 - resultForC;
    
end

x = opt/(opt+nonopt);


end