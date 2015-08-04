function [ opt ] = NetEst3( C )

%% Explanation
%NetEst3 takes thematrix of connections from layer 1 to layer 2 C
%and tells you whether or not the network is optimal.
%This calc is simplified because the three layer network estimate is just 
%linal

[~, layer1] = size(C);

if( rank(C) < rank( [C ; ones(1,layer1)] ) )
    opt = 0;
else
    opt = 1;




end  %of function

