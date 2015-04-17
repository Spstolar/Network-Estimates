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
minconnected = eye(L(1));


%First add the connections from the second layer to the last.
C(sum(L),L(1)+1:L(1)+L(2)) = 1;

%Next we preconnection from the second layer up to the first to make sure
%that no agent in the second layer is left out.


for j = 1:L(2)
    %randomly pick one of the agents in the first layer
    pick = randi(L(1));
    %assign the connection from that first layer agent to our agent
    C(L(1)+j, pick) = 1;
    minconnected(:,pick) = zeros(L(1),1);
end

%Now make sure everyone in the first layer is connected:

%matrix with exactly one in every column
layer2draw = eye(L(2));
connectonce = layer2draw(:,randi(L(2),1,L(1)));
C(L(1)+1:L(1)+L(2),1:L(1)) = C(L(1)+1:L(1)+L(2),1:L(1)) + connectonce*minconnected;

%Next, we throw up extraconnections.
if extraconnections >0
    for i = 1:extraconnections
        pick1 = randi(L(1));
        while sum(C(:,pick1)) == L(2) %if the agent is fully connected, pick a different one
            pick1 = randi(L(1));
        end
        pick2 = L(1) + randi(L(2));
        while C(pick2,pick1) == 1
            pick2 = L(1) + randi(L(2));
        end
        C(pick2,pick1) = 1;
    end
end
 

%right now we may run into more extraconnections that we want because of
%the preconnection from layer 1 to layer 2. This is fine for right now.