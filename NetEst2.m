function [ x ] = NetEst2( C, L)
%NetEst1 Calculting estimates given the connection matrix, and for now
%assuming equal variance of 1 for the top layer.

%C is the matrix of connections:
%column i tells you who agent i sends info to

%L is the vector that tell you how many agents are in each layer. L(i) is
%the number of agents in layer i, so L = [L(1) L(2) ... L(num of layers)]


%It's good to test this on 
%C = ConnectionMatrix(8,[1 4],[2 4 5],[3 5],[4 6],[5 7],[6 8],[7 8])
%L = [3 2 2 1]

N = sum(L);             %total number of agents
I = zeros(N,N);         %initial info matrix
K = length(L);          %number of layers


%this gives the matrix whose column i tell you who agent i receives info from
TC = transpose(C);


%The first a second layers are easier to compute directly, so we do those
%and leave the third and on layers to an algorithm which uses covariance
%matrices

%define the info matrix for the top layer
for k = 1:L(1)
    I(k,k) = 1;
end

%define the info matrix for the second layer
for k = 1:L(2)
    for j = 1:N
        I(j,k + L(1)) = TC(j ,k+L(1))./sum(TC(:,k+L(1)));
    end
end

m = L(1);


%defining for the rest of the layers
for k = 3:K   %starting at layer k = 3 and going till layer k = K the bottom
    for v = (m+L(k-1)+1):(m+L(k-1)+L(k))   %going through each agent of layer k
        
        %the matrix of layer 1 weights that layer k-1 is using
        P = I(1:L(1),m+1:m+L(k-1));
        
        %the column for agent i of layer k telling us who the is receiving 
        %info from
        r = TC(m+1:m+L(k-1),v);
        
        %J to index going to each elt of the previous layer and asking if they are
        %sending info
        %R = number of people who send info to the agent
        % we use to index the matrix we'll use to build the covariance matrix
        J = length(r);
        R = sum(r);
        
        %setting up the matrices we use to build the covariance matrix WF
        Q = zeros(L(1),R);
        WF = zeros(R,R);
        
        %used to enter in the proper weights
        nextcol = 1;


        %Goes through the people in the layer above. If they are giving this agent
        %info, then adds their weights to the matrix Q.
        for i = 1:J
            if r(i) == 1
                Q(:,nextcol) = P(:,i);
                nextcol = nextcol +1;
            end 
        end
        
        for i = 1:R
            for j = 1:R
                WF(i,j) = transpose(Q(1:L(1),i))*Q(1:L(1),j);
            end
        end

        %WF is the RxR covariance matrix, which may be singular
        %Check if it's singular, and if it is de-singularize it, where we
        %keep track of what we removed from WF
     
        %isitsing = singcheck(WF);
        %cond(WF);                  %<-- for debugging
        
        
        if singcheck(WF) == 1
            [WF, removed] = desing(WF);
        end


%          WF might have been resized;
        inR = R;
        [R, ~] = size(WF);
        
        %IWF = inv(WF);    %replaced inv(WF) below with /WF

        b = (ones(1,R)/WF)*ones(R,1);

        
        weights = (ones(1,R)/WF)/b;
        fillw = zeros(1,inR);
        
        %we have to add in some zeros if we reduced the covariance matrix
        if R < inR
            p = 1;
            q = 1;
            for fillspot = 1:inR
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
        
        for l = 1:inR
            est = est + weights(l)*Q(:,l);
        end
        I(1:L(1),v) = est;
        
        recw = 1;
        for p = 1:J
            if r(p) == 1
                I(m+p,v) = weights(recw);
                recw = recw + 1;
            end
        end
            
        %sum(weights);
        
    end
    
    
    m = m + L(k-1);
    

end







        
x = I;

end

