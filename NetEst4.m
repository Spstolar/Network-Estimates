function [ opt ] = NetEst4( C )

%% Explanation
%NetEst4 takes thematrix of connections from layer 1 to layer 2 C
%and tells you whether or not the network is optimal.
%This calc is simplified because the three layer network estimate is just 
%linal.
%NetEst4 includes a check for non-connected agents because I'm now
%calculating using the binomial distribution. 

[~, layer1] = size(C);



if (prod(sum(C,2)) > 0)
    %optvec = double( sum(C) > 0 )
    optvec = ones(layer1);
    if( rank(transpose(C)) < rank( transpose([C ; optvec] )) )
        opt = 0;
    else
        opt = 1;
    end
else
    opt = 0;
end




end  %of function

