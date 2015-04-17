function[ C ] = ConnectGen2(L, extraconnections)

% input L = the vector of layers 
%totalconnections = how many connects the top layer should send to the
%second
% e.g., L = [6 3 1];
%       totalconnections = 7;
% this gives 5 top layer members sending down one connection, and one other
% top layer member sending down two connections, then the second layer
% agents all add to the third layer



C = zeros(sum(L),sum(L));
totalconnections = extraconnections + L(1);

minconnected = ones(L(1),1);


%First add the connections from the second layer to the last.
C(sum(L),L(1)+1:L(1)+L(2)) = 1;

%First we preconnection from the second layer up to the first to make sure
%that no agent in the second layer is left out.

%Right now this will have the effect of adding more than totalconnections

for j = 1:L(2)
    %randomly pick one of the agents in the first layer
    pick = randi(L(1));
    %assign the connection from that first layer agent to our agent
    C(L(1)+j, pick) = 1;
    minconnected(pick,1) = 0;
end

%Now make sure everyone in the first layer is connected:

C(1:L(1),L(1)+1:L(1)+L(2)) = minconnected
%Next, we throw up extraconnections.

toconnect = sort(perm(L(1)*L(2),extraconnections);
for i = 1:extraconnections;
    C(mod(toconnect(i),L(2)),ceil(toconnect(i)/L(2))) = 1;
end

for i = 1:L(1)
    if sum(C(:,i)) == 0
        pick = L(1) + randi(L(2));
        C(pick, i) = 1;
    end
end

if extraconnections > 0
    for k = 1:extraconnections
        pick1 = randi(L(1));
        while sum(C(:,pick1)) == L(1) %if the agent is fully connected, pick a different one
            pick1 = randi(L(1));
        end
        pick2 = L(1) + randi(L(2));
        while C(pick2,pick1) == 1
            pick2 = L(1) + randi(L(2));
        end
        C(pick2,pick1) = 1;  %note/caution for future that this ignores the fact that this may already be a connection
    end
end
% 
% for j = 1:length(L)-1  %work from bottom layer up to the second layer
%     thislayer = length(L)+1-j ;    %labelling for ease of concept
%     layerabove = thislayer - 1;
%     for k = 1:L(thislayer)         %go through the agents of this layer
%         thisagent = sum(L(1:layerabove))+ k;
%         pick = sum(L(1:layerabove-1)) + randi(L(layerabove));   %pick a random agent from the layer above
%         
%         %if the agent already has the max # of connections need a while loop
%         %to choose a different agent
%         if connectto(pick) > 0 
%             C(thisagent, pick) = 1;  %otherwise add this connection
%             connectto(pick) = connectto(pick) - 1;  %subtract 1 from how many connections the picked agent can now send
%         else
%          
%             while connectto(pick) == 0       %keep looking till we have someone who can send a connection
%                 pick = sum(L(1:layerabove-1)) + randi(L(layerabove));              
%             end
%             
%             C(thisagent, pick) = 1;  
%             connectto(pick) = connectto(pick) - 1;
%                
%         end
%         
%         %now that we have insured that this agent gets info from someone
%         %above, we add the rest of its connections (if any) to the layer
%         %below
%         
%         if connectto(thisagent) > 0    %check if the agent has any connections required
%             %connect it up randomly
%             v = sum(L(1:thislayer))*ones(1,connectto(thisagent)) + sort(randperm(L(thislayer+1),connectto(thisagent)));
%             for l = 1:connectto(thisagent)
%                 C( v(1,l) , thisagent) = 1;
%             end
%         end
%         
%     end
%         
% end
%     

%Now finish the first layer connections:
% 
% for j= 1: L(1)
%     if connectto(j) > 0    %check if the agent has any connections required
%             %connect it up randomly
%         v = L(1)*ones(1,connectto(j)) + sort(randperm(L(2),connectto(j)));
%             for l = 1:connectto(j)
%                 if C( v(1,l) , j) == 0
%                     C( v(1,l) , j) = 1;
%                 else
%                     row2agent = v(1,l);
%                     while C(row2agent, j) == 1
%                         row2agent = randi(L(2))+L(1);                     
%                     end
%                     C( row2agent, j) = 1;
%                 end
%             end
%     end
% end
    



