function[x] = singcheck(A)

%[M, ~] = size(A);


%%Protection from matrices with NaN entries
 done = 0;

% for m = 1:M
%     if done == 0
%         if isnan(A(1,m))
%             %A = delagents(A,m);
%             done = 1;
%             x = 1;
%         end
%     end
% end

%determinant method
if det(A) == 0
    x = 1;
    done = 1;
end

%Conditioning method.
if done == 0
    x = (cond(A) == inf) | (abs(cond(A)) < 10^-10) | (cond(A) > 10^10) | (isnan(cond(A))) | (rcond(A) < 10^-10);
end

%Eigenvalue method.
if x == 0
    if prod(eig(A)) == 0
        x = 1;
    else 
        x = 0;
    end
end