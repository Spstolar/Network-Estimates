runs = 10;
L = [6 3 1];

for i = 1:runs
    A = randi(2,6,3)-ones(6,3)
    sum(A,2)
    sum(A(:,[1 2]),2)
    sum(A(:,[2 3]),2)
    sum(A(:,[1 3]),2)
    [I,Aerror] = TestConnectionMatrix(A);
    if Aerror > (1/L(1))+.00001
        'nonoptimal'
    end
end