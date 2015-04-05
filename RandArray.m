function[ x ] = RandArray(c,N)


%create a c-element array drawing number from 1 to N

assignments = zeros(1,c);
assignments(1) = randi([1,N],1,1);


for i = 2:c
    u = randi([1,N],1,1);
    while all(assignments - u*ones(1,c)) == 0
        u = randi([1,N],1,1);
    end
    assignments(i) = u;
end

x = sort(assignments);


w = randi([1,N],1,12);

any(w);

all([1 2 3]-2*ones(1,3));

