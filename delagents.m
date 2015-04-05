function[x] = delagents(C, a)

repeat = 0;

%do nothing for repeated indices

if length(a) > 1
    for j = 1:length(a)-1
        for k = j+1:length(a)
            if a(j) == a(k)
                repeat = 1;
            end
        end
    end
end
            
            
            
            
if repeat == 0            
    a = sort(a,'descend');


    % input an nxn matrix C and a vector distinct integers from 1 to n
    %returns the matrix with those integers deleted
    for i = 1:length(a)
        C(:,a(i)) = [];
        C(a(i),:) = [];
    end
end

x = C;