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
    WF;
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
    if R==3
        %see if deleting one row and column works
        check = singcheck(delagents(WF, 1))+singcheck(delagents(WF, 2))+singcheck(delagents(WF, 3));
        if check == 3
            %del 2 at a time
            %since all that is left is the diagonal entry, the choice is irrelevant
            WF = delagents(WF,[1 2]);
            y = [1 2];
%             if singcheck(delagents(WF,[1 2])) == 0 
%                 WF = delagents(WF,[1 2]);
%                 y = [1 2];
%             else
%                 if singcheck(delagents(WF,[2 3])) == 0
%                     WF = delagents(WF,[2 3]);
%                     y = [2 3];
%                 else
%                     WF = delagents(WF,[1 3]);
%                     y = [1 3];
%                 end
%             end
        else
            if singcheck(delagents(WF,1)) == 0
                WF = delagents(WF,1);
                y = 1;
            else
                if singcheck(delagents(WF, 2)) == 0
                    WF = delagents(WF, 2);
                    y = 2;
                else
                    WF = delagents(WF,3);
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
    for f = 1:R
        if repaired == 0
            if singcheck(delagents(WF, f)) == 0
                WF = delagents(WF, f);
                repaired = 1;
                y = f;
            end
        end
    end
end


if repaired == 0
    for e = 2:R-1
        %deleting an agent means to delete the row and column for the
        %agent's position
        %we have to delete anywhere from [2 rows and 2 columns] to [R-1 rows and
        %R-1 columns]
        % When the deletion is invertible, we are done and have reached a
        % minimal e. Once there, we set: repaired = 1
        
        %1. Pick e distinct numbers from 1 to R. This must be done
        %systematically to be sure that we are doing the deletions
        %minimally.
        
        %2. Delete the columns and rows corresponding to those numbers
        
        %3. Check if the det is nonzero:
        % if det == 0, then restore and keep going
        % if det =/= 0, then this is what we want. Halt the alg and set WF
        %               equal to this deletion
        
        %while det(WF) == 0
        if repaired == 0
            a = ones(1,e);
            for s = 1:e
                a(s) = s;
            end
            while a(e)+a(e-1) < 2*R
                WF = delagents(WF,a);
                if size(WF) == size(B) %skip redudant deletions
                    a = arrayincrement(a,R);
                else                  
                    if singcheck(WF) == 1
                        a = arrayincrement(a,R);
                        WF = B;
                    else
                        repaired = 1;
                        y = sort(a);   %ordering the agents we removed
                        a(e) = R*e+3;    %ensuring the end of the while loop
                    end
                end
            end
        end
            
    end
end

x = WF;
%y;

