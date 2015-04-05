function[x] = desing(B)

WF = B;
[R s] = size(WF);

det(B)

% for e = 1:R
%     e
%     tB = B;
%     tB(:,e) = [];
%     tB(e,:) = [];
%     det(tB)
% end


if det(WF) == 0
    repaired = 0;
else
    repaired = 1;
end

if repaired == 0
    for e = 1:R-1
        %we have to delete anywhere from 1 row and column to R-1 rows and
        %columns
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
        
        WF = delagent(WF,e)
        WF = B
            
    end
end

x = WF;
    
%         if det(WF) == 0
%             %delete minimal number of rows and columns alg
%                 %starting with checking if we can get by with 1 row and
%                 %then increasing till the max required deletions
%             deWF = WF
%             for e = 1:R
%                 deWF(e,:) = [];
%                 deWF(:,e) = [];
%                 if det(deWF) == 0
%                     deWF = WF;
%                 else
%                     cWF = deWF;
%                     deWF = WF;
%                 end
%             end
%             WF = cWF;
%             
%         end