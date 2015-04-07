function[ C ] = ConnectGen(L, ConnNums)

% input L = the vector of layers and ConnNums = how many connects each member of
%the layer has to the next layer
% e.g., L = [6 3 1];
%       ConnNums = [2 1];
% this gives 6 members of the top layer who each send down 2 connections
% and each member of the second layer will all connect to the final
% observer


C = zeros(sum(L),sum(L));

connectto = 0;

for i = 1:length(L)-1
    connectto = [ConnNums(length(L)-i)*ones(1,L(length(L)-i)) connectto];
end



%First we preconnection from the bottom up to make sure no agent is left
%out.

for j = 1:length(L)-1  %work from bottom layer up to the second layer
    thislayer = length(L)+1-j ;    %labelling for ease of concept
    layerabove = thislayer - 1;
    for k = 1:L(thislayer)         %go through the agents of this layer
        thisagent = sum(L(1:layerabove))+ k;
        pick = sum(L(1:layerabove-1)) + randi(L(layerabove));   %pick a random agent from the layer above
        
        %if the agent already has the max # of connections need a while loop
        %to choose a different agent
        if connectto(pick) > 0 
            C(thisagent, pick) = 1;  %otherwise add this connection
            connectto(pick) = connectto(pick) - 1;  %subtract 1 from how many connections the picked agent can now send
        else
         
            while connectto(pick) == 0       %keep looking till we have someone who can send a connection
                pick = sum(L(1:layerabove-1)) + randi(L(layerabove));              
            end
            
            C(thisagent, pick) = 1;  
            connectto(pick) = connectto(pick) - 1;
               
        end
        
        %now that we have insured that this agent gets info from someone
        %above, we add the rest of its connections (if any) to the layer
        %below
        
        if connectto(thisagent) > 0    %check if the agent has any connections required
            %connect it up randomly
            v = sum(L(1:thislayer))*ones(1,connectto(thisagent)) + RandArray(connectto(thisagent),L(thislayer+1));
            for l = 1:connectto(thisagent)
                C( v(1,l) , thisagent) = 1;
            end
        end
        
    end
        
end
    

%Now finish the first layer connections:

for j= 1: L(1)
    if connectto(j) > 0    %check if the agent has any connections required
            %connect it up randomly
        v = L(1)*ones(1,connectto(j)) + RandArray(connectto(j),L(2));
            for l = 1:connectto(j)
                C( v(1,l) , j) = 1;
            end
    end
end
    



