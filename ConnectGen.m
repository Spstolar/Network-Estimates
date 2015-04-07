function[ C ] = ConnectGen(L, ConnNums)

% input L = the vector of layers and ConnNums = how many connects each member of
%the layer has to the next layer
% e.g., L = [6 3 1];
%       ConnNums = [2 1];
% this gives 6 members of the top layer who each send down 2 connections
% and each member of the second layer will all connect to the final
% observer


C = 0;

connectto = zeros(1, sum(L));

for i = 1:length(L)-1
    connectto = [ConnNums(length(L)-i)*ones(1,L(length(L)-i)) connectto];
end


%First we preconnection from the bottom up to make sure no agent is left
%out.

for j = 1:length(L)-1  %work from bottom layer up to the second layer
    thislayer = length(L)+1-j     %labelling for ease of concept
    nextlayer = length(L)-j
    for k = 1:L(thislayer)         %go through the agents of this layer
        pick = randi(L(nextlayer));   %pick a random agent
        
        %if the agent already has the max # of connection need a while loop
        %to choose a different agent
        
        %otherwise add this connection
        
        %add a backwards counter for the layer labelling when we input the
        %connection
        
        %subtract from the connectto vector if the agent is picked
        
        %maybe adding to the pick to begin with will ease this
        
        %complete the preconnections
        
        %use the connectto entries to decide how many random agents we need
        %to connect to, now working from the top down
        
        %could do this in the same loop
    end
        
end
    
    
    
l = 0;

% for j = 1:length(L)-1
%     l = l + L(j);
%     for i = 1:L(j)
%         v = l*ones(1,ConnNums(j)) + RandArray(ConnNums(j),L(j+1));
%         for k = 1:ConnNums(j)
%             C( v(1,k) , l - L(j) + i  )  =  1 ;
%         end
%     end 
% end


