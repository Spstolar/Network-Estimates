function[x] = singcheck(A)

[M, ~] = size(A);

done = 0;

for m = 1:M
    if done == 0
        if isnan(A(1,m))
            %A = delagents(A,m);
            done = 1;
            x = 1;
        end
    end
end

if done == 0
    x = (cond(A) == inf) | (abs(cond(A)) < 10^-10) | (cond(A) > 10^10) | (isnan(cond(A)));
end