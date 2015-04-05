function[ C ] = ConnectGen(L, ConnNums)

% input L = the vector of layers and ConnNums = how many connects each member of
%the layer has to the next layer
% e.g., L = [6 3 1];
%       ConnNums = [2 1];
% this gives 6 members of the top layer who each send down 2 connections
% and each member of the second layer will all connect to the final
% observer

C = zeros(sum(L),sum(L));
l = 0;

for j = 1:length(L)-1
    l = l + L(j);
    for i = 1:L(j)
        v = l*ones(1,ConnNums(j)) + RandArray(ConnNums(j),L(j+1));
        for k = 1:ConnNums(j)
            C( v(1,k) , l - L(j) + i  )  =  1 ;
        end
    end 
end


