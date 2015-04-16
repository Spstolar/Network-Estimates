function[x] = singcheck(B)

x = 0;
done = 0;

if sum(eig(B) == 0) > 0
    x = 1;
    done = 1;
end

% if done == 0;
%     if abs(prod(eig(B))) < .000001
%         x = 1;
%         done = 1;
%     end
% end

if done == 0;
    ConditionB = cond(B);
    if ( ConditionB == 0) || (isinf(ConditionB) ==1) || (isnan(ConditionB) == 1) || (ConditionB < .000001) || (ConditionB > 1000000000)
        x = 1;
    end
end