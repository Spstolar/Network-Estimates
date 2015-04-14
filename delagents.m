function[x] = delagents(C, a)
    % input an nxn matrix C and a vector of distinct integers from 1 to n
    %returns the matrix with those integers deleted
    
    


%For efficiency, we do nothing for repeated indices.

repeat = 0;

if length(a) == 2
    if a(1) == a(2)
        repeat = 1;
    end
end

if length(a) >1
    if a(length(a) - 1) == a(length(a))
        repeat = 1;
    end
end

if length(a) > 2
    for j = 1:length(a)-2
        for k = j+1:length(a)
            if a(j) == a(k)
                repeat = 1;
            end
        end
    end
end
            
            
            
            
if repeat == 0            
    a = sort(a,'descend');
    alength = length(a);


    for i = 1:alength
        C(:,a(i)) = [];
        C(a(i),:) = [];
    end
end

x = C;