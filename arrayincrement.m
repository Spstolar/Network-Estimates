function[x] = arrayincrement(a,R)


a(1) = a(1) + 1;
carry = 0;

if a(1) == R+1
    carry = 1;
end

if carry == 1
    for j = 1:length(a)
        if carry == 1
            if a(j) > R
                a(j) = 1;
                a(j+1) = a(j+1) + 1;
            else
                carry == 0;
            end
        end
    end
end

x = a;