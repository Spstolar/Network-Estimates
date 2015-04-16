function[x, y] = desing(B)

%  takes a matrix B, tests invertibility, then if it's 
%not invertible removes as few row(i)+column(i) combinations as possible to get an 
%invertible matrix 
% The resulting matrix is x, and y keeps track of what we removed.
y = 0;
WF = B;
[R, ~] = size(WF);

det(B);


if singcheck(WF) == 1
    repaired = 0;
    needtodelete = R - rank(WF);
    e = needtodelete;
else
    repaired = 1;
    y = 0;
end

if repaired == 0
    if R == 2
        if B(1,1) > B(2,2)   %since we are only using matrices whose diagonal entries are positive, this check suffices
            repaired = 1;
            y = 2;
            WF = B(1,1);
        else
            repaired = 1;
            y = 1;
            WF = B(2,2);
        end
    end
end

if repaired == 0
    if R == 3
        %see if deleting one row and column works
        %WF minus column and row 1
        WFm1 = WF;
        WFm1(1,:) = [];
        WFm1(:,1) = [];
        %WF minus column and row 2
        WFm2 = WF;
        WFm2(2,:) = [];
        WFm2(:,2) = [];
        %WF minus column and row 1
        WFm3 = WF;
        WFm3(3,:) = [];
        WFm3(:,3) = [];
        check = (singcheck(WFm1) == 1)+(singcheck(WFm2) == 1)+(singcheck(WFm3) == 1);
        if check == 3
            %del 2 at a time
            %since all that is left is the nonzero diagonal entry, the choice is irrelevant
            %We choose to delete columns and rows 1 and 2
            WF(:,[1 2])= [];
            WF([1 2],:) = [];
            y = [1 2];
        else
            if singcheck(WFm1) == 0
                WF = WFm1;
                y = 1;
            else
                if singcheck(WFm2) == 0
                    WF = WFm2;
                    y = 2;
                else
                    WF = WFm3;
                    y = 3;
                end
            end
        end
        repaired = 1;
    end
end

                
    
%First we'll do the remove one case, hopefully this will be all that is
%needed

if repaired == 0
    if e == 1
        for f = 1:R
            if repaired == 0
                WF(f,:) = [];
                WF(:,f) = [];
                if singcheck(WF) == 0
                    repaired = 1;
                    y = f;
                else
                    WF = B;
                end
            end
        end
    end
end


if repaired == 0
    %deleting an agent means to delete the row and column for the
    %agent's position
    %We have to delete exactly e column/row pairs.
    
    %1. Pick e distinct numbers from 1 to R. This must be done
    %systematically to be sure that we are doing the deletions
    %minimally. We do all combinations of e numbers between 1 and R, using
    %nchoosek(1:R,e)
    
    %2. Delete the column/rows corresponding to those numbers
    
    %3. Check if the det is nonzero:
    % if singular, then restore and keep going
    % Otherwise, this is what we want. Halt the alg and set WF
    %               equal to this deletion
    

    %go through all possible deletions of a subset of e agents
    combinations = nchoosek(1:R,e);
    for poss = 1:length(combinations) %check the combinations one at a time
        if repaired == 0
            %if the matrix was still singular, check next comb
            WF(:,combinations(poss,:)) = [];
            WF(combinations(poss,:),:) = [];
            if singcheck(WF) == 1
                WF = B;
            else
                repaired = 1;
                y = combinations(poss,:);   %ordering the agents we removed
            end
        else
            %no check required, we are done and we can finish out
            %the for-loop. This will weight selections toward
            %deleting lower indices though
            
        end
    end
end

x = WF;


