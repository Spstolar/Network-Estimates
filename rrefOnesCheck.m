function[ y ] = rrefOnesCheck( A , n)
% n is the number of columns of A
%this returns 1 if the vector of 1s is in the rowspace of A and 0 otherwise



y = 0;

B = sum(rref(A));

if (B == ones(1,n))
    y = 1;
end
